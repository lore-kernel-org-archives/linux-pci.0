Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934764AbeEWWUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 18:20:54 -0400
Date: Wed, 23 May 2018 15:20:39 -0700
From: Kyle McMartin <jkkm@fb.com>
To: Rajat Jain <rajatja@google.com>
CC: Jes Sorensen <jsorensen@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: RFC: Counters for PCI Express AERs
Message-ID: <20180523222039.GA1014@boosh.jkkm.org>
References: <CACK8Z6Hjxd+6qRthHEQRuo0_NXX06iDqggrVN83O0QkN=3+9gg@mail.gmail.com>
 <dee623fb19f82f3a600dd816cba9f489@codeaurora.org>
 <CACK8Z6FGxkO5JGQs3Rs2-2dtqDFnFgsmq5HT2D4nv0eGUZSg8g@mail.gmail.com>
 <CACK8Z6F+PN=aoRaApRnG6To8JcFUUXXBok4QNS5Nziwt4We01A@mail.gmail.com>
 <cf07f933-5fd9-918d-4cb2-a9a79285801f@fb.com>
 <CACK8Z6HKyQ-wZfUpStha0ZYcn9z5F63ohnXPHwBowq0_SC=mHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CACK8Z6HKyQ-wZfUpStha0ZYcn9z5F63ohnXPHwBowq0_SC=mHA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 09:31:11AM -0700, Rajat Jain wrote:
> >>> Jes: did anything come out of the proposal? I'm wondering if you have
> >>> any patch that in work-in-progress that I could use may be as a
> >>> starting point?
> >
> > Kyle McMartin was working on this, I don't know the current status.
> 
> 
> Never mind, I think I'm more than halfway there and will be sending a
> patch in a day or two.
> 

Patch set looks good to me, it's pretty analogous to what I came up with
in the fall. I ended up using the tracepoints instead of patching in sysfs
to enable it across all of our kernel versions in production.

Really glad you did this work, hopefully it gets merged.

cheers, Kyle
