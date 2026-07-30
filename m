Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B831F99E;
	Thu, 30 Jul 2026 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386440; cv=none; b=RxOxml0UBFp/XT6Tgo1kL+N4KrtMUkZdjlcb8SeXr9hGsUQfxXvyAF/1oVcD6HEAY2GmZKpQHXZ5YDUBjclPYixTVjvd8KcNX3C2xjAJy9X8xbJpNvtNdo38Qh0wNTryJLnvQzvkoEmtVlRXXMqVPGkRPqL/HumPX0vQh+J8Y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386440; c=relaxed/simple;
	bh=XDaYQKs7te3poeuthqZgwZ5UdhkkLXATe7EvMsmRY0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhEkdg7rfBUK+a7knIWh1dx6iev5qFO6rrVc7Bf49MiW4uTUutGqgMV/f8ABhfMmdk6i+4RIKAP5pcpy1SimskmcmfGBRWx0tMQbG7aNy3D2Sw73M3J774mQmtfhJt8kJaO3TrLqpe1Sh62qgsk7LWE7KT3UZ0a4nqEqX80aAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV0Z9VMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV0Z9VMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44A81F000E9;
	Thu, 30 Jul 2026 04:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386437;
	bh=/+uIiEPkcCiBkxhcN1xcVUiu4yK/Kv76tH3noXyzxqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CV0Z9VMrmUtNTKfzFQNDmGCvPc35ekhdec1IsDIS38ez7p/oBqaP+CjKQeUaUfh3i
	 3o2CoXCew+OhJa2R4XRfAmw560amtBzw+SCs7sCx78GMCsW009g7/d9O2TXDhgwfig
	 KCyc/m8evDTTsH0VABP0qm8NBrn+2rLClIgxlLF08IK3AzDkdLi7rTvCAIzKT4OUFQ
	 bwae6+sxZpZIcDYrXMpoWijgLJUeOTBuvJaXksf4bSfg4azBYZWEWya4Z5b4i+mjDm
	 pkdss/0d0KDSiLQlSl/ku5LcIpFtno9/WfxwNuw9loHNNfYSwZIRutbQdj54ZgCtjP
	 wB8WSNlZrIipA==
Date: Thu, 30 Jul 2026 06:40:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] PCI/ASPM: Disable/restore ASPM on every function
 for multi-function devices
Message-ID: <oexbxvtxozvqw5kwv34skbv2ipumrkgjnrla6gferpdtwjdma3@sqxkfr2fpvql>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-2-2ebb3ee7ef71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-aspm-v6-2-2ebb3ee7ef71@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 07:32:37PM +0530, Krishna Chaitanya Chundru wrote:
> pcie_aspm_cap_init() disables ASPM L0s/L1 before touching L1SS config,
> then restores the pre-existing state afterward. Both steps only ever
> touched link->downstream, i.e. function 0 of the downstream component,
> leaving sibling functions (>0) on a multi-function device untouched.
> 
> This means the "disable" step does not actually disable ASPM link-wide
> on a multi-function device: a sibling function can still have L1
> enabled even after this step runs. PCIe r6.2 sec 7.5.3.7 recommends
> programming the same ASPM Control value for all functions of a
> multi-function device, and pcie_config_aspm_link() already loops over
> every function on the bus for exactly this reason.
> 
> Loop over every function on linkbus->devices for both the disable and
> restore steps, keeping the existing PCIe r6.2 sec 7.5.3.7 ordering
> (disable downstream functions before upstream, restore upstream before
> downstream functions). The masked pcie_capability_clear_and_set_word()
> accessor from the previous commit makes this safe: it only ever
> touches the ASPM Control bits, so function-specific bits elsewhere in
> LNKCTL (e.g. Read Completion Boundary, CLKREQ Enable) on sibling
> functions are left untouched.
> 
> Fixes: 7447990137bf ("PCI/ASPM: Disable L1 before disabling L1 PM Substates")

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260721143945.86E7D1F000E9@smtp.kernel.org/

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
