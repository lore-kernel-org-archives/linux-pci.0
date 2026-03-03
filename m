Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96F370D45;
	Tue,  3 Mar 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555923; cv=none; b=O8PgM67IxvNEQR3Tdnon0/O8aL2pPHFyJEuFp6GE0t66AWD7wtuTAdkQl3kUWPXrIWE/QFTOeCSUZbgQThMsIk2K3G7GBRy8mPEVvmI27PPpjcRUMd85tRH93Car2YBPPwu+UOpyWD154gbHyGh/eaNxJoMxR1yUH+wUn4YUCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555923; c=relaxed/simple;
	bh=lxeNyqMRRI9fL4eYmbH8oZ+nwJE9/XGPxmznsDIrVC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlB99gUF8r19EpW/Al818INv7YRpynHtAg+c8DH/I4a5FnnXRLp/8CIdJtNPzUT2IZsB5eQ9P0JV1t9ifJ1uSNQGoLTxd3cfEnh2BHuY98lIcExvcoKLQioPUM67td6m0Ndv8wDDEKuWawZSU8YpQJTvq0+ACE9UQkD6mPQQXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrmrh/Uf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrmrh/Uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E9C116C6;
	Tue,  3 Mar 2026 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555922;
	bh=lxeNyqMRRI9fL4eYmbH8oZ+nwJE9/XGPxmznsDIrVC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jrmrh/UfdXRmDeQFjkuIaJKOltOxNdbFhfXFSkPKITeXW0OSp8csrG6TrjyAqcMha
	 7JssawiTsRd/p1E5crBihv2t+kaJlcDARtXw4GAGkccnjyisEdEI0WsuV6cVjgqOzv
	 cMPAAJa+sa8jmfhpExDMHcNuIUWk1M+4cBMYSWvomfQQ8EQTVtOYOHNF3AYlLdTeLF
	 LhyMiE7HH+zSqgUt9lNHxkhW4TUaGpj4RlhU8runUP7L0PB6tc3VSwEVxvW7mZRKe2
	 fM0izilv5esqNgr7g2JiBU6+Vf7yCN4oUZTBf2vhjSacCAExH+WLTWprW9H4FTeh2S
	 ujywis8EiKOZA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
In-Reply-To: <20260303000207.1836586-9-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
Date: Tue, 03 Mar 2026 22:08:34 +0530
Message-ID: <yq5a8qc8amwl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Once one accepts the threat model that devices may be adversarial the
> process of establishing trust in the device identity, the integrity +
> confidentiality of its link, and the integrity + confidentiality of its
> MMIO interface requires multiple evidence objects from the device. The
> device's certificate chain, measurements and interface report need to be
> retrieved by the host, validated by the TSM and transmitted to the guest
> all while mitigating TOCTOU races.
>
> All TSM implementations share the same fundamental objects, but vary in how
> the TSM conveys its trust in the objects. Some TSM implementations expect
> the full documents to be conveyed over untrustworthy channels while the TSM
> securely conveys a digest. Others transmit full objects with signed SPDM
> transcripts of requester provided nonces. Some offer a single transcript
> to convey the version, capabilities, and algorithms (VCA) data and
> measurements in one blob while others split VCA as a separate signed blob.
>
> Introduce a netlink interface to dump all these objects in a common way
> across TSM implementations and across host and guest environments.
> Userspace is responsible for handling the variance of "TSM provides combo
> measurements + VCA + nonce + signature, vs TSM provides a digest over a
> secure channel of the same".
>
> The implementation adheres to the guideline from:
> Documentation/userspace-api/netlink/genetlink-legacy.rst
>
>     New Netlink families should never respond to a DO operation with
>     multiple replies, with ``NLM_F_MULTI`` set. Use a filtered dump
>     instead.
>
> Per SPDM, transcripts may grow to be 16MB in size. Large PCI/TSM netlink
> blobs are handled via a sequence of dump messages that userspace must
> concatenate.
>

Should we also expose evidence->generation to userspace so it can be
used during accept()? This would allow us to ensure that the device is
accepted using the same evidence generation observed by userspace.

-aneesh
