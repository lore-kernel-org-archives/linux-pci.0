Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59253 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab3IXVYF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2013 17:24:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH V3] pci: exynos: split into two parts such as Synopsys part and Exynos part
Date: Tue, 24 Sep 2013 23:23:55 +0200
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Thierry Reding'" <thierry.reding@gmail.com>,
	"'SRIKANTH TUMKUR SHIVANAND'" <ts.srikanth@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <000701ce8741$fe47deb0$fad79c10$@samsung.com> <20130923041427.GC2246@pratyush-vbox> <523FD286.608@ti.com>
In-Reply-To: <523FD286.608@ti.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309242323.55323.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 23 September 2013, Kishon Vijay Abraham I wrote:
> Btw if we hadn't programmed inbound translation table, the address will go
> untranslated (according to the data book). I guess that's how it was working
> for Jingoo Han.
> 
> **
> 3.10.4
> Inbound iATU Operation
> 
> When there is no match, then the address is untranslated
> **
> 

Well, that should work just as well, since you have a 1:1 translation anyway.
Do you get the same error without the translation?

	Arnd
