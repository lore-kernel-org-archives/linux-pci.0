Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:47289 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaCPMFp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 16 Mar 2014 08:05:45 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so4211334qab.4
        for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2014 05:05:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGG0vUgk7u6pDRJ9f+vFm9DvGyiE_M7N_Ux0EskpYwuJJvneDQ@mail.gmail.com>
References: <CAGG0vUgk7u6pDRJ9f+vFm9DvGyiE_M7N_Ux0EskpYwuJJvneDQ@mail.gmail.com>
Date: Sun, 16 Mar 2014 14:05:44 +0200
Message-ID: <CAGG0vUgp9bc=xxp4T672sfm+Y-JQWmvXtdnQonGcHQUZ4WENcg@mail.gmail.com>
Subject: [bisected] e501 "agp: Support 64-bit APBASE" agp fails without iommu=remap=2
From: =?UTF-8?B?Sm91bmkgTWV0dMOkbMOk?= <jtmettala@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi. I can't start xsession without iommu=remap=2 kernel parameter.

Kernel bisect lead to commit e501b3d87f003dfad8fcbd0f55ae17ea52495a56
agp: Support 64-bit APBASE

Reverting this fixes it for me.

I think this is relevant part of dmesg from affected kernel

agpgart-amd64 0000:00:04.0: AGP bridge [10b9/1689]
agpgart-amd64 0000:00:04.0: aperture from AGP @ 0 size 4096 MB
pci 0000:00:18.3: no usable aperture found
pci 0000:00:18.3: consider rebooting with iommu=memaper=2 to get a good aperture
agpgart-amd64 0000:00:04.0: AGP bridge [10b9/1689]
agpgart-amd64 0000:00:04.0: aperture from AGP @ 0 size 4096 MB
pci 0000:00:18.3: no usable aperture found
pci 0000:00:18.3: consider rebooting with iommu=memaper=2 to get a good aperture
agpgart-amd64 0000:04:00.0: AGP bridge [1002/4150]
agpgart-amd64 0000:04:00.0: aperture size 4096 MB is not right, using
settings from NB
agpgart-amd64 0000:04:00.0: AGP aperture is 256M @ 0xa0000000

Please cc me if you need more information. I am not subscribed to list.
