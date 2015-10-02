Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp304.stejtech.net ([91.236.209.154]:54818 "EHLO
	smtp304-outgoing.stejtech.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767AbbJBOc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 10:32:26 -0400
Received: from promail.crossnet.net (unknown [213.132.113.130])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp304.stejtech.net (Postfix) with ESMTPS id 94CF92833FC
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2015 16:24:10 +0200 (CEST)
Subject: Fwd: SWIOTLB on 32-bit PAE.
References: <560E9007.1000604@t2data.com>
To: <linux-pci@vger.kernel.org>
From: Christian Melki <christian.melki@t2data.com>
Message-ID: <560E92A0.9030707@t2data.com>
Date: Fri, 2 Oct 2015 16:20:16 +0200
MIME-Version: 1.0
In-Reply-To: <560E9007.1000604@t2data.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I discovered a strange error on my machine. 32-bit PAE 4.2.0 without
IOMMU code (yeah, I know).
When writing to an ext4 filesystem on a USB disk my kernel would hang
and not return control to userspace. It would spew kernel messages to
syslog as fast as it could without giving userspace any time, ie "hang"
as far as a user sees it. The device itself is ok and the filesystem is
clean.
I get messages like this, millions of them.

Oct  2 14:33:06 voodoochild kernel: [  223.287447] nommu_map_sg:
overflow 25dcac000+1024 of device mask ffffffff
Oct  2 14:33:06 voodoochild kernel: [  223.287448] nommu_map_sg:
overflow 25dcac000+1024 of device mask ffffffff
Oct  2 14:33:06 voodoochild kernel: [  223.287449] nommu_map_sg:
overflow 25dcac000+1024 of device mask ffffffff

I disovered that SWIOTLB was not on. It is only provided for 64-bit
machines where it is default. On 32-bit SWIOTLB seems disabled unless 
you are running with some IOMMU/AGPGART code.

But what about 32-bit PAE? Would that not qualify for SWIOTLB without IOMMU?

I am a novice in this area. Maybe this is a Kconfig "bug" for us that 
like to hang ourselves with CONFIG_* rope? :) I'd like to think that 
SWIOTLB should be default for 32-bit PAE too?

Best regards,
Christian


