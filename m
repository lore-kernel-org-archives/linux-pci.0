Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370218;
	b=zHRdLfWx1cXdxXbOFST6q4/HIdbgvkQiNWBunP/yq80XpvlckDf9xMyMhR57XBIaqIY1
	 T0DXiP0hBgpxOBeWg6dRr/eN88sRiRsg13XuOfsGiK6gdHXWh4ErFad6oLRKQ7zW+EzMd
	 jT4ZHG25gN1xfNi6zY51jJb7A+7vQod5/RpRHImwiP2QKu031LHPahenEkuoK2QHJGnZM
	 s/ogdsUu/YhkEVy484A4l88KYCSOhqDn4wgmblk6rqPmORbdIhp6qeLza/NDGkbXCX3cl
	 M4fdtOylVwMl5w3nUaAJC9aJLl9cp9udQI+kJKipjTpNiB5j6Ph4keMADbfgFIjfPhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370218;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SRarPMJXtSd+wHz5Q7zGG/WU2xZAhIr3bcGSZg9SwW8=;
	b=VbxKzSOPRKhjbs1pv7xqgrxI3NtQEKEizJM4sb/Rp+8N46dYbHvk3VSLvf7JMBLTjOjf
	 F8eNTXP13Xs/hot0FOouocl7DtW/Tq6iwYI8ghcja/wRe7jeGOjtIGMN6jk25mJWBk8Zs
	 Bk8pk/ed8r7X4TfU3dtgmXvfjKxIWXwDtLGgKLF8oyJ8dxhWwKVnsXcRKneAx5trZY2uR
	 gNfcG0mlKigzpb3qP4O1oifSntlLDkPuQru1OpPsaCC+FLgnMHujv6hV88X6261R7JKi+
	 18vkJf3iy5OfWHb8isWdW7mu08JFFj+kbyoJu17xww94KlP9AOi2KVp7bqNs7JYkTZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E693606A32A;
	Sun, 22 Nov 2026 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E693606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id B82E2C3D;
	Sun, 22 Nov 2026 18:56:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8403B6013161; Sun, 22 Nov 2026 18:56:48 +0100 (CET)
Date: Sun, 22 Nov 2026 18:56:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices
 without AER
Message-ID: <awMs4CwlPT2vsDV2@wunner.de>
References: <20261110215614.3931232-5-yazen.ghannam@amd.com>
 <20261121013125.GA934416@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121013125.GA934416@bhelgaas>

On Fri, Nov 20, 2026 at 07:31:25PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 10, 2026 at 03:56:14PM -0600, Yazen Ghannam wrote:
> > aer_attr_group is a named group, so sysfs creates an "aer" directory for
> > every PCI device. aer_attrs_are_visible() hides the attributes when the
> > device has no aer_info.
> > 
> > But this doesn't apply to the entire "aer" group. So devices without AER
> > end up having an empty "aer" directory.
> 
> This applies specifically to the ratelimit-related things in the "aer"
> directory, right?

Yes.

> If so I might amend this commit log to mention
> that, since Lukas's subsequent "PCI/AER: Enable baseline capability
> error reporting" enables aer_dev_correctable, aer_dev_fatal, etc even
> for non-AER PCIe devices.

With that subsequent patch, the "aer" subdirectory with the ratelimiting
knobs appears below every PCIe device (unless allocation of aer_info fails
due to high memory pressure), but not e.g. below Conventional PCI devices.

> At least they're internal so they're easier to change than
> "aer_dev_correctable" etc, which are even more unfortunate now.

Baseline capability error reporting depends on presence of an AER-capable
Root Port, hence is still in a sense AER-related.

Thanks,

Lukas
