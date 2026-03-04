Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF53D1CAE;
	Wed,  4 Mar 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647294; cv=none; b=YF0U2ytnfXK0gMEHvib6Q07B1xDGsFbxrUOh7GuykBquJZdAmN+BCJCgZRPZlkgo8fnk0mR7s4iROTD0jyvM8QB9i7WOaz8e4YfKTNd+kfB2D7UKesQMBkRWU8bhl21IBDX8BC8h99zl/uG22QYNyfxBjUPbk99SbTVZuHBXwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647294; c=relaxed/simple;
	bh=SxnzQBt9Ot6eHMRYQurulLKTi0GMXW/OCWYbnRMqOu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk1/qcN5d7Ro9fWzIxVTwjpydGta/pcjjUhpSDBcR2JksxNNgAzFr5fl50cRHp2D5pjgcXjrStVPoq3CXvPdwAJRvribT8xl1PsANktuloe99pjRICwpcbpf0Z6+6s6Wb/eJ6EEj/SBpRGIyYA8lVV3Vlm4gJA7EwkPKGBfqkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 22AD820201B0;
	Wed, 04 Mar 2026 18:52:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 124422CFDA; Wed,  4 Mar 2026 18:52:19 +0100 (CET)
Date: Wed, 4 Mar 2026 18:52:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rich Hanes <georgebastille@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Don't call pci_pm_power_up_and_verify_state()
 for devices already in D0
Message-ID: <aahxU99mfH2LZfrZ@wunner.de>
References: <20260304170324.67076-1-georgebastille@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304170324.67076-1-georgebastille@gmail.com>

On Wed, Mar 04, 2026 at 05:03:24PM +0000, Rich Hanes wrote:
> Reproduced on a Lenovo ThinkPad with Intel Wireless-AC 7265 (8086:095a)
> behind PCIe root port 8086:9d10.  The workaround pcie_aspm=off confirms
> that suppressing L1 PM substate configuration prevents the failure.

The same issue was observed on a Google Pixelbook Eve:
https://bugzilla.kernel.org/show_bug.cgi?id=220705

That laptop also uses an i7265 attached to a Sunrise Point-LP PCH.

The PCH suffers from a hardware erratum, it doesn't reinstate the
clock quick enough after CLREQ# assertion to stay below the
spec-prescribed 400 nsec.

Intel's specification update recommends disabling CLKREQ# support
at the Root Port to work around the issue.  This must be done by
the BIOS, an operating system patch isn't the right approach.

I've prepared a BIOS change for the coreboot BIOS used on the
Pixelbook, see the above-linked bugzilla.  It has not been
upstreamed yet as I'm waiting on the reporter to test it.

If your ThinkPad can be made to boot with coreboot, I can look into
porting the patch over to your machine.  Please specify the exact
Thinkpad model you're using.  Otherwise please check whether Lenovo
has released a BIOS update for your machine.

Thanks,

Lukas
