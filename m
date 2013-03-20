Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42326 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286Ab3CTBLo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Mar 2013 21:11:44 -0400
Message-ID: <51490CC8.80903@zytor.com>
Date: Tue, 19 Mar 2013 18:11:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Matthew Garrett <matthew.garrett@nebula.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
References: <k1r3u75sumyfkayvoobjrce1.1363741640644@email.android.com>
In-Reply-To: <k1r3u75sumyfkayvoobjrce1.1363741640644@email.android.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/19/2013 06:07 PM, Matthew Garrett wrote:
> Yeah, I'd like the option of relaxing restrictions when drivers explicitly opt in based on iommu support.

When drivers opt in they can provide an interface.  The interesting case
becomes non-drivers.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

