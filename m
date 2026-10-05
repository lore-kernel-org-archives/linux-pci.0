Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCB4AA56B;
	Mon,  5 Oct 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214986; cv=none; b=pNQVj+VBRY0xxUX3fHEVnbFpHzXMIK6iUmm7BuR9Va9kw6GiXCxIBSO26KDZG5nXt7z0MFmpizqQX7JDjceosFFTaL9VBhpj3l5AR7ebvXAqbKmCtkR/nnFg22s7btc5ffe4iceH7nsE7RT14uIOp6hdeHBUfBDVmfcNafKQdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214986; c=relaxed/simple;
	bh=g4OhxTLUxgz9o1WkKYCRk/xeXsgjQSUAOfctlquRGqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GKy28OkR30WT3eWHUY7+P5faIxqIaKsW+OaLEfe6TZc+Qc6xKoAkQ/CuQD+K7b8irEkSGDLgAPL+oy738qMhoJI5jmGDr9X/bu/OxwBEI2Kj8kUKAUI7hkeNNnWMqMp7SQSyV4ry0rqwyMQBoH8RExlwdLjeWyt8NFQTBgjj0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQhA8QHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQhA8QHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D571F000FF;
	Mon,  5 Oct 2026 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214985;
	bh=6PI88WdSt6VgLF4s94gizOPDvuQ+/X5oICgkQnIhKjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VQhA8QHwxCXCdCE+bj4XB/uff9kpm6/bZj+GUKRA24x9MA/1KeWDE4En1lccu/k1r
	 Gxek2teeIYPRfEdU6lMlcsl17Tn2c2BDeXATKNZxSCkLJC64RT+dVqpdMaWDGm3fuq
	 L/Ww/dArYnDY9i3acXcetWCECcz3B+zjEb7ImdL5x/y+yRYUU3gQRfbntrlxHkXg6c
	 AH5p34rnHvXmj20Gi78+qIlIbeHImgWljO6tyiH1PKFVuXO6OSPa8HWIFgN1JPBhXL
	 lGzUrQwJ9b8Cj3GISWWDYHEgKeuCHRr0i7HvUIBTdKR/aMsdt0X0FjQi0DN3VdWjd7
	 ZAqvC0RizTAKA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dmaengine@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Dave Jiang <dave.jiang@intel.com>, George Ge <george.ge@microchip.com>, 
 Jaeyoung Chung <jjy600901@snu.ac.kr>
In-Reply-To: <20260902062153.31048-1-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
Subject: Re: [PATCH v6 00/10] dmaengine: miscellaneous fixes for ioat,
 switchtec_dma and plx_dma
Message-Id: <179121498284.358863.10846435154613116455.b4-ty@kernel.org>
Date: Mon, 05 Oct 2026 17:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 02 Sep 2026 00:21:42 -0600, Logan Gunthorpe wrote:
> This is the latest series of fixes that has been rebased onto v7.3-rc1.
> 
> After getting more Sashiko feedback on the two problematic patches I
> have to eat crow and appologize. Frank was correct about them and I
> was a bit too stubborn. Sorry about that. I have dropped those two
> patches in this series so hopefully it can go in quickly.
> 
> [...]

Applied, thanks!

[01/10] dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
        commit: bdfd76514bd11301f4e67d150485ab696c26d83d
[02/10] dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
        commit: 1188942d6160b9f799af297bdb5d7812cd7fde6d
[03/10] dmaengine: switchtec-dma: fix channel leak on registration failure
        commit: fd39726ab7096840cc9c9dea6dfba23834fc81f0
[04/10] dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
        commit: 50bf400915d308b80729bae8c6c85f001d7b7295
[05/10] dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error
        commit: 268f9159ebf38a7ed134e5008e705d8ff99e1c20
[06/10] dmaengine: switchtec-dma: disable channels before freeing on registration failure
        commit: 5b4c561554b2f802a4e3db539ba2c586b72b7721
[07/10] dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
        commit: 9f744689c49defa61238836829202d1473da2ea5
[08/10] dmaengine: ioat: disable relaxed ordering before registering the device
        commit: 10d34fbca6e09a6a18d64fa3ebaa3db9f27fc1a6
[09/10] dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
        commit: c691357acf76037b8a58ee4eb0ae07cd708a8ba1
[10/10] dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()
        commit: f3017892457d8bb664ea4b912910dc254e2dd825

Best regards,
-- 
~Vinod


