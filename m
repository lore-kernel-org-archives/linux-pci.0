Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:34353 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbG2Qez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 12:34:55 -0400
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
To: Joerg Roedel <joro@8bytes.org>,
	Andreas Hartmann <andihartmann@freenet.de>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com> <20150721155635.GE10969@8bytes.org>
 <55AE7147.7070902@maya.org> <20150721163517.GG10969@8bytes.org>
 <55B1BDA3.3030507@maya.org>
 <CAErSpo666MBxpDe+uPvfVc7LPJsJQsVTusBhHygtwbou5GGj1w@mail.gmail.com>
 <55B27CEB.6010007@maya.org> <20150729152208.GS10969@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From: Andreas Hartmann <andihartmann@freenet.de>
Message-ID: <55B8FFCB.30602@maya.org>
Date: Wed, 29 Jul 2015 18:31:07 +0200
MIME-Version: 1.0
In-Reply-To: <20150729152208.GS10969@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jörg,

On 07/29/2015 at 05:22 PM, Joerg Roedel wrote:
> Hi Andreas,
> 
> On Fri, Jul 24, 2015 at 07:59:07PM +0200, Andreas Hartmann wrote:
>> New information: During testing, I now realized that Linux 4.0.9 shows
>> the same problem ... . I'm now testing 3.19.4.
> 
> Have you seen the issue on 3.19 too or hasn't it happened there at all
> yet? The question is where to look for a commit that breaks it on  your
> machine.

3.19 works perfectly. It's an issue with new dm crypt:
http://www.spinics.net/lists/dm-devel/msg24019.html


Thanks for asking!
Regards,
Andreas
