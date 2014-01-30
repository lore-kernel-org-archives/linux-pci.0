Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62611 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbaA3OVk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 09:21:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [RFC PATCH V3 0/4] APM X-Gene PCIe controller
Date: Thu, 30 Jan 2014 15:21:11 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dann Frazier <dann.frazier@canonical.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	linux-doc@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	patches <patches@apm.com>, Jon Masters <jcm@redhat.com>
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com> <CAErSpo7Dfd4NJBEDuVe1VCvZObFq1YvV2x77S60Z4-CZq89QJw@mail.gmail.com> <CACoXjc=LSrLK=kd9GJoHWJovVDC+TfH2bZO-2Ht9jMoBrL9eag@mail.gmail.com>
In-Reply-To: <CACoXjc=LSrLK=kd9GJoHWJovVDC+TfH2bZO-2Ht9jMoBrL9eag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201401301521.11665.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 January 2014, Tanmay Inamdar wrote:
> >
> > When you repost, please make sure you fix whatever problem is
> > preventing your email from appearing on the vger mailing lists.  I
> > won't apply things that haven't appeared on the linux-pci list,
> > because that list is the opportunity for other people to review them.
> >
> You are absolutely right. If the patches are not reaching mailing
> list, they should not appear on archive list as well. However I am
> seeing my patches recorded on archives. So I am not sure if they are
> actually getting dropped on linux-pci or any other mailing list.
> 
> http://www.spinics.net/lists/linux-pci/msg28198.html
> http://article.gmane.org/gmane.linux.kernel.pci/28442/match=tanmay+inamdar

Very strange. I can also confirm that I received the patches through
the linux-arm-kernel and devicetree mailing lists without problems.

	Arnd
