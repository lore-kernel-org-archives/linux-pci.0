Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:62555 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbaDNSsW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Apr 2014 14:48:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>
Subject: Re: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Date: Mon, 14 Apr 2014 20:48:17 +0200
Message-ID: <21141977.8ucQJzlJts@wuerfel>
In-Reply-To: <20140414171300.GL12916@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <20140403220713.GA23545@google.com> <20140414171300.GL12916@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 14 April 2014 18:13:00 Will Deacon wrote:
> Arnd: Is there anything more you'd like me to do with this series? Given
> that it would be targetting 3.16, there's still plenty of time to make
> changes (we talked about extracting some library functions in the past).

I don't remember the latest status of your patch set, but you might want
to read the discussions we had about Liviu's patches last week.

We still haven't figured out exactly how to handle I/O space in the common
code, but I think we are making progress.

We also have discussed some ideas about how to restructure the PCI
code layer to make it easier to share host drivers across architectures
and clean up the interfaces in the process.

	Arnd
