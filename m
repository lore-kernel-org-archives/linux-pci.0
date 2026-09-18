Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD6437852;
	Fri, 18 Sep 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753809; cv=none; b=PfG9g4voxly2SG/vHC6RPbULoI+vGUl3zAV6zROqaYPfsEsYXUsd5ajh41J/WHL4vNVPBvQOyahFX4kRPDKC86IPHSue8DVipb59W5AS7wn09ZoSZhF26+bSLbLKHyCh8qsfaiSJTf5JfLLv8saJ0Jhaf9HhVoXUa/oY5oTKMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753809; c=relaxed/simple;
	bh=4gZ0FMiI6XZimt5LeuPfNfp8lE8IGxnZSUdnt9aNpbE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k4JU3zmYy9/Xn+8PTJ4XWk6o3jCwd9oIb+HYYWx7UKr8hBvAjjJLVbZJ8vagwy/MLHPNiCUEJueD08chcOejXDANAZW94EwgkhB5oUM5HBh60ISbwtFnJy5bmsachNteC5slNbwf2OIItqbUeTzUA8tIGRFTzYaHZU0jEKO6BFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dVSQ3wUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pff9zcjS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dVSQ3wUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pff9zcjS"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C8D514001C8;
	Fri, 18 Sep 2026 13:49:59 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 13:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789753798;
	 x=1789840198; bh=rwFEq0r82EwgoDi0U6/f4zaurev8d0PbwLI36YNXpgI=; b=
	dVSQ3wUaOZVfOrB2Ts9YjCEjikpHLyoAuqYSNtf6rWD88OGCHMYEEDVJdV3N1k27
	hRHmFDxOGqh23QgIjQ8NfBKwVhIHIS8M28B6Vw96Pff9eWRMfeyapihQxPYmEdNh
	Oho3G/njKIDpgyyPG7A7l6ox2cxiwD9fGnwz83T3CbWrAZ/4MPvrdGZ1XmLrj6bU
	QIocQ9ho9EBKSjLuxF3+ybVnt+NvDKop+PKQYGdmRK7EQkzJ+TiANacGJps1hLQF
	SItq9t4IQXYK8lk/a5PtiF/9VmAyr2x0a7JyiY90tNt9VF9LCa28be+5XRI490sw
	WrCDHtOyJ8Ge/UM+/bKY3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789753798; x=
	1789840198; bh=rwFEq0r82EwgoDi0U6/f4zaurev8d0PbwLI36YNXpgI=; b=P
	ff9zcjSAQHQMkniMPuUa2LXa7m6L+EUEm24ITTlk1wUAr24gyA3YZcspSrSqUtqC
	wNoT2H7U69X/t0WyIqF8ZL4VDhuE8T/OMYae2aTdAaJRrBgFk0C4ci3x+FVk9HzY
	W/mg9eNGeT6hhBEpyBTWfkFacvaCksrTsFBBtU2r2kwdvqZbDrv8z+06qBb0UGYE
	8jdxE5PXBBcr+R4OuCUAPzINx1EzH2ScqaAantw3Q3aG0AzLNUbz5oYN2p47+7hM
	AgeUdRPWI577DuoOFyGF5UCFG4qdNBt2gsJD05R5sQLVwwmpiamoZP2pTrVaBsp7
	wzeGCx9Nl5y3smaLJSDDA==
X-ME-Sender: <xms:wHmtajQ3fmhWzUiIpeXoeHXYjq_UejlPvRM2LhDa3VXvUubEk3dwXw>
    <xme:wHmtavkM1bq2-JOlS9pflITG4HF9An3buRNTIY8QPQtNS3uG-ousKeejC2cPeFYSV
    E_47UvJXF0xBDd_bsd5n9T1u4Vzj3Zhq3eTq4jQMkEb6_pqvWWip2Bi>
X-ME-Proxy-Cause: dmFkZTE8cn8/lGNqiXeNSp03dS61vDyJvYMTjkv9quP3Aq9fV5/PWgJJz4y7/2enhd6dGY
    mf7kd+Ea4Nrwp7ddcslF8rlxTCKPswgWJtGGvwBZ3fm+gOtLnZ+ppsmOAlucvuZo/gv0Ul
    8A7lhIrMeoV3tQhL2YukxQ0t3M2qF/la5OmwceerKQSSm3vgCOpykSuKwl794KqhN31X5t
    gDwUTY524uU9JIa7EMm+IrT/tCr8Su940pO1qWAGMnCQSxj09u3thLSYuH16Wsdh++e8z3
    D3EFtR33+x7mzUG3qS8uQGvY/8v/Mt9lGnhgFcRHOY0DLXPzmXQeNkeTxaPHtvaH8inmPe
    QV7t104gvLwmS6mDJ8Sy9REr2YG2iSfmoCJVucmJJCFGuSc4NYIpEivjVnt0+kRlmN5PBM
    JaAVTyLhC832Fxr8f1csEqP4mR4UKRb1nAbOcI31XsNgqd9QBs9JGN7B41aCQ8Fh/Fta8n
    t+mxvzPaZA+TaBJy+qgrLSZuw/V8WSEsh7PqmcV1NkfgmGAf2YYsDmCrHu6abkyc8RhppX
    V8aC93FGdJg6MOBOOtgEfo0e/bae2IyN84cc7RvixDg5bEs4c+IbWMic+1kx4nU5qiGemg
    VLUvE/OZtxlemsrqHQvOknMwVwYcaT9jJmNmVZ+9bRnX6vL6kY2F+g9Xctpg
X-ME-Proxy: <xmx:wnmtah2q1OoYzeQ6wYL6mfd_TqiW23AwHyVTdKwVmFSRDkzG5u_1qg>
    <xmx:wnmtag0YR6PD2BX8DUpHXqF0nJdFB9IeZs0myKGOBWfBpFuicaH2Vg>
    <xmx:wnmtagkLfCEG0IN-nxh33OQomNhRMbOzq_PI_7PgbVdfxr1q6x1E7A>
    <xmx:wnmtahNgIRDZB9HYIwkgzEffHfH95D8N_kY8p8qnW8qHeSdDIxlC3A>
    <xmx:xnmtatUPZKB_gTGahd9Zx-1X2AK5vqbCOnqYgJRemDG_ysUWThQnI-Ii>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3658432A0085; Fri, 18 Sep 2026 13:49:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v-knPnKEnN
Date: Fri, 18 Sep 2026 19:46:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Ray Jui" <rjui@broadcom.com>,
 "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Rosen Penev" <rosenp@gmail.com>,
 rani.hod@gmail.com
Message-Id: <95e4b5ed-2f72-4bfe-85d8-9cd7b45a5fa7@app.fastmail.com>
In-Reply-To: 
 <CAAsRjR=sHgZMgXuTid+D7Vst=N_GBUZUrduZ4YZax5rbotHNMg@mail.gmail.com>
References: <20260917183602.GA1036092@bhelgaas>
 <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
 <CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com>
 <dc370463-125e-48d2-af6b-c3b4783f57ea@app.fastmail.com>
 <CAAsRjR=sHgZMgXuTid+D7Vst=N_GBUZUrduZ4YZax5rbotHNMg@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2026, at 18:25, Semih Baskan wrote:
> On Fri, Sep 18, 2026 at 12:32:12PM +0200, Arnd Bergmann wrote:
>> If the DT window doesn't match, how does the bcma driver find
>> the device node that corresponds to the EROM entry to populate
>> the child nodes?
>
> By reg. bcma_of_find_child_device() in drivers/bcma/main.c compares the
> first reg address of each child of the axi node with the core's register
> base from the EROM. That base is 0x18012000, 0x18013000 and 0x18014000
> on both revisions; only the outbound window differs. The pcie node's
> ranges is not looked at. The reg is translated through the axi node's
> first ranges entry. The PCI core then matches the wifi nodes below that
> node by devfn.

Ok, makes sense.

>> The driver should probably check earlier if the device is
>> already bound to the bcma bus, rather than just trying to
>> request the bus windows. If anything, I would have expected
>> the conflict on the 18012000 address for the register
>> base.
>>
>> I see an ioremap() of bdev->addr in drivers/bcma/scan.c but
>> don't see a corresponding request_resource() for it, so maybe
>> an easy fix is to add this to the bcma bus scan and
>> make sure that always happens before the pci driver probe?
>
> In the tree as it is, neither side claims the register base. bcma
> only ioremaps it in scan.c, and pcie-iproc-platform maps its reg with
> devm_pci_remap_cfgspace(), which does not request the region either.
> That is why the window is the first thing the two collide on. On the
> ordering, bcma_bus_register() calls bcma_bus_scan(), then
> of_platform_default_populate(), then bcma_register_devices(), so the
> scan is done before the pcie platform devices are created and the
> bcma core devices are registered after that.

Ok, so adding the regular resource management to both sides here is
probably a good idea anyway, though it is not sufficient as long the
platform driver gets probed first.

>> If a board has nothing connected to one of the host bridges,
>> why is the pcie host bridge still marked as status="ok"?
>> Do you need a driver to put it into low-power mode, or
>> should this just be marked as disabled?
>
> The three nodes are in bcm-ns.dtsi without a status property, and no
> Northstar board file disables one. Which controllers carry a device
> differs per board: the RT-N18U has one on the first, the R8000 on the
> first, and on the second through a switch with two radios behind it.
> bcma takes the cores from the EROM, and bcma_register_devices() skips a
> core whose node is not available, so a node marked status = "disabled"
> is skipped there too, and neither driver would take that core. I do not
> know whether an unused core needs a driver for power.

Ok

>> Does the platform driver reprogram the windows to match the DT
>> description, or does it rely on the boot loader to ensure they
>> ranges/dma-ranges properties match the register contents?
>
> It programs OARR/OMAP from ranges only when the node has
> "brcm,pcie-ob", and the inbound side only when it has dma-ranges.
> The bcm-ns.dtsi nodes have neither, so it programs nothing and runs
> with what is in the registers at boot. The PAXB_BCMA register table
> has no OARR/OMAP at all, and the bcma driver never asks for an
> outbound mapping, so it does not program them either. OARR0/OMAP0
> are in the PAXB table the platform driver uses, at 0xd20 and 0xd40;
> I have not written them on revision 0x01. Broadcom's 2.6.36 driver
> writes OMAP/OARR 1:1 from its own table: 0x08000000, 0x40000000 and
> 0x48000000, with the last two replaced by 0x20000000 and 0x28000000
> when the core revision reads 0x07.

Ah, interesting. So if the problem with the platform driver
is that the outbound windows are mismatched between the register
settings and the ranges property, wouldn't it make sense to always
set "brcm,pcie-ob" for boards that are known to have more than
one possible setting in their firmware?
That way I would hope the platform driver can just work in the cases
that currently fail.

>> When using the bcma driver, does that update the ranges properties
>> in memory to match the EROM contents?
>
> No. 552aa843e4c5 drops the windows parsed from ranges out of the
> bridge's resource list and adds the EROM one; the patch in this
> thread reads ranges only to compare them with the EROM window. The
> property in the live tree is not touched, so /proc/device-tree keeps
> the dtsi values and the mismatch shows up only as the warning.

Ok. I suspect this may cause problems when someone uses an MFD
device that needs to translate internal registers of child device
through the ranges. It's probably not a big deal since those devices
are rare, just something to keep in mind.

    Arnd
