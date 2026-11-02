Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661376;
	b=PgAtQMJyuhMscgWAQYFpvHFMdzAM53wn9CXm/wkyYFlb/kiGT0bC2Zr5MLLM06BEP/uO
	 lJ45qGd4V+5aoSOrHEb2Utg72ux8X31sP4a3Teamkw0Q0cW1OaIy75AKJQunbPBto+zmb
	 NwVYR7dUGgp+VFv5kivrElvBrE3KNdgvjvOqt63fhtkuTyw/frdgXIxCxe34llvWOFE1Z
	 nn9CYj3DpRp74nyepIKXiHj0EhYW0hAsGMr20Cp0zW/Rv57BzHGGunRoQRPFja/En4SLX
	 BEaqTI2bw/iD1GZJ5VKc9RUTe4oDOKQrtBfCrAvpI40udB7NnS1eZV6dD3LWQjjJKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661376;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UcjCzXz5IJVcuXeXUDQ9tzNpo2Te/iR+ykAFbn2DRuk=;
	b=BOzEZWHP1GYVjBe3yCI/rrZyTBqaACX1h6L5Iy/lb6NHnFpcD2S/GRMR1hg3mYxN1HOe
	 1sWvuj4HinM9ACFFg8ofd7jDftYGSCHRDuXWmfNJncEiFP9Sskqox3efLSR+HN/SmXrxc
	 iXQ26pj7gp0IhwkGnUGdaqfJx7ABSv3/nGirDnlR41Zb13uRZUobmz8cJoj5Y2e37LlmP
	 feDpJDTiGceXnI8OBFgDfuflW24sWdCyfYNrHmhQ3ycOxVmpe5Mubd5UnY8DISBtrdoJn
	 /gc1OGmobPmS20mjGAgWCPOZLfV2i2n6sPLPO9aM8sV2zmKghOx/ZIH//w4u3msQAHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372B606A326;
	Mon,  2 Nov 2026 23:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8372B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 184161D4E;
	Tue, 03 Nov 2026 00:16:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 016E2602D909; Tue,  3 Nov 2026 00:16:06 +0100 (CET)
Date: Tue, 3 Nov 2026 00:16:06 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, terry.bowman@amd.com, kanie@linux.alibaba.com,
	olof@lixom.net
Subject: Re: [PATCH v15 1/4] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Message-ID: <aukZtm4aLMuH_JIB@wunner.de>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aujwl45XrkVT-zUx@wunner.de>
 <840c7598-f988-428a-8bea-4d66b0f4f4d7@linux.intel.com>
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
In-Reply-To: <840c7598-f988-428a-8bea-4d66b0f4f4d7@linux.intel.com>

On Mon, Nov 02, 2026 at 12:38:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 11/2/2026 12:20 PM, Lukas Wunner wrote:
> > This is now commit 6347fd9aee19 in Linus' tree and I think there's a problem:
[...]
> > The commit is setting the native_pcie_hotplug bit up front based on
> > CONFIG_PCIEPORTBUS.
> > 
> > But there's an if-clause at the top of get_port_device_capability() which
> > adds PCIE_PORT_SERVICE_HP to the port services used by a given PCIe port.
> > 
> > Inside the if-clause is code to disable hotplug interrupts if the BIOS
> > left them enable.
> > 
> > Since the commit, if CONFIG_PCIEPORTBUS=n, the if-clause is no longer
> > entered and so the interrupts are no longer disabled.
> 
> I don't think this case changed. get_port_device_capability() is in
> portdrv.c, which is only built with CONFIG_PCIEPORTBUS=y:
> 
>   obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
> 
> So with CONFIG_PCIEPORTBUS=n, the if-clause was never entered, before or
> after this commit.

Okay, that convinces me, thanks for the explanation.

> Did you see a case where the interrupts stay enabled with this commit?

Nope, just thought "this looks fishy" when I rebased my development branch.

Thanks!

Lukas
