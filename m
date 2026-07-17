Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489E285072;
	Fri, 17 Jul 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327689; cv=none; b=g2k8ZfOCUis3JSkHzmrTikSmv+sVf9FnmZcAFTp5+JuFcLbRlOThkC6ApT9m35ypzLiAIFIDtZOV+AymG5yho+HDRYeQlK//WnMY3UScaCLzYYUufYyQ20Qt1dSY/uk9LzLg9x6GfLk9BGMap0gaofbJaV3H+RS8wYTxAYcQujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327689; c=relaxed/simple;
	bh=bJ0AMDuVy/OauloIFBdwLk0F8B3/tSXbggpe/sDV2cI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DS1GVlDuDlLFvlKvTr7G2xUxG4Al/La01yCy3w9oLj7Pb6OHWhkeoEFwi43oivWMtwAy4oTTJNXEVsECEuaW4iouzIH4gq4z+sgEjkmRYDGGzRa0bWkkSzsFM6fJJsc8hzDaQMhFK9jUZ/RBtoIcbosRpHG4sUhu7xr3OAMuXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYZFr4KR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYZFr4KR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FEF1F000E9;
	Fri, 17 Jul 2026 22:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327688;
	bh=YLIqwSpapYpLbtT604LKuYMcMZzcoowxlqZD4UwmqaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYZFr4KRAX3Sqy+qIMGXNxmGnrOAvYeQqOh/n51wgt5cLowINIcJrmTjCd7wTsLCn
	 jnVBxX4kDr4+vu7HuMKfYwyGqYCS1tU1j3YxG9hWybxw9i+9Sdb/5iVfDZizlRaHXy
	 4JUPnAJPZZm9s/TymmNpJvwZiofxpYl82LBPcgWmXIvaoHOzMes8WQEGeLV6SkXZ3v
	 78LfQGKPWswmAaJJTInbY+uXNzn80sWia2P7Rs6FaJ51YwhJbMnPOHFAO+EAmv6aCc
	 LSJNv641pp5vt5jh6Ob0VfcBRqnZTBzYqDa+UZIziKS2mmYJXIkIzvdfTWr3zcilN1
	 wfuODDI80sWRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] dmaengine: ioat: disable relaxed ordering before
 registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260717221001.361421-5-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:34:47 +0000
Message-Id: <20260717223447.B3FEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Partial failure in dma_async_device_register() leaks global dma_id=
a and per-device chan_ida.
- [High] Use-after-free in ioat_dma_do_interrupt() due to mixing devres IRQ=
 registration with manual kfree on the probe error path.
--

--- Patch [4]: [PATCH v1 4/6] dmaengine: ioat: disable relaxed ordering bef=
ore registering the device ---
(Note: The format of this review is altered from the usual inline commentin=
g style due to recitation restrictions. No patch diffs are quoted below.)

commit 29a5621a4420e7d413fe2125067821903edd8980
Author: Logan Gunthorpe <logang@deltatee.com>
dmaengine: ioat: disable relaxed ordering before registering the device

This commit fixes a dangling device registration issue by moving the=20
PCIe relaxed ordering disablement before the dma_async_device_register()=20
call. This ensures that the device does not remain in the core's list=20
if an error occurs later in the probe function.

Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.ke=
rnel.org/T/#u

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential=20
resource leak in drivers/dma/dmaengine.c:dma_async_device_register().

When a failure occurs and device->chancnt is greater than 0, the code=20
jumps to the err_out label. However, this path seems to bypass freeing=20
the global dma_ida:

err_out:
    /* if we never registered a channel just release the idr */
    if (!device->chancnt) {
        ida_free(&dma_ida, device->dev_id);
        return rc;
    }

Additionally, the loop that unregisters the channel devices omits calling=20
ida_free(&device->chan_ida, chan->chan_id) and device->chancnt--.=20

If a device probe fails due to memory pressure or hotplug errors, will this=
=20
leak the global dma_ida and per-device chan_ida? If the global dma_ida=20
space is exhausted, it might prevent any further DMA devices from=20
registering system-wide.

[Severity: High]
This is also a pre-existing issue, but is there a risk of a use-after-free=
=20
on the probe error path?

In drivers/dma/ioat/init.c:ioat_dma_setup_interrupts(), a shared interrupt=
=20
is registered via devm_request_irq(), tying its lifetime to the device core=
.=20
However, if ioat_pci_probe() later fails, it manually calls kfree(device):

ioat_pci_probe() {
    ...
    if (err) {
        for (i =3D 0; i < IOAT_MAX_CHANS; i++)
            kfree(device->idx[i]);
        kfree(device);
    ...
}

Because the IRQ was allocated with devres, it remains active until=20
ioat_pci_probe() returns and the driver core runs the devres cleanup.=20
If another device sharing this interrupt line triggers an IRQ during this=20
window, wouldn't drivers/dma/ioat/dma.c:ioat_dma_do_interrupt()=20
dereference the freed instance pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D4
