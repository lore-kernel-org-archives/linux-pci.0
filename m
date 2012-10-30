Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56912 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab2JaH1j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 03:27:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 03/15] SPEAr13xx: Add mach/io.h
Date: Tue, 30 Oct 2012 21:45:46 +0000
Cc: viresh kumar <viresh.kumar@linaro.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
References: <cover.1351492562.git.pratyush.anand@st.com> <CAOh2x==1McRP4eNFZa8qH4hjnOr003Ozb6J3XP8B87E9yZB4zw@mail.gmail.com> <508E3A2E.3000204@st.com>
In-Reply-To: <508E3A2E.3000204@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201210302145.47011.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 29 October 2012, Pratyush Anand wrote:
> Any transaction between 0x80000000 to 0x8FFFFFFF can only be used for 
> any type(IO/MEM/CFG0/CFG1) of PCIe transaction. Therefore , we need to 
> have this mapping in io.h.

No you don't.

The I/O space window will only be in one place on a given system, so you
should register that window using pci_ioremap_io() as all the other
modern platforms. There is no excuse for having a per-platform mach/io.h
any more and that would prevent you from enabling spear in a multiplatform
configuration.

	Arnd
