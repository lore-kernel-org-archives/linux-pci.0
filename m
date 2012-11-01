Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:39378 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643Ab2KAH0M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Nov 2012 03:26:12 -0400
Message-ID: <50922400.4090502@st.com>
Date: Thu, 1 Nov 2012 12:55:52 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shiraz HASHIM <shiraz.hashim@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 04/15] SPEAr13xx: Add PCIe Root Complex driver support
References: <cover.1351492562.git.pratyush.anand@st.com> <201210302220.23690.arnd@arndb.de> <50910A64.7040306@st.com> <201210312200.59324.arnd@arndb.de>
In-Reply-To: <201210312200.59324.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/1/2012 3:30 AM, Arnd Bergmann wrote:
> Thanks for the quick replies. I hope I managed to explain the I/O space accesses
> now.

Yes, I understood now :)

Also looked into pci_ioremap_io. Things are clear now.

Will send V2 after incorporating all comments.

Regards
Pratyush


