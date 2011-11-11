Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60774 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab1KKU3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 15:29:54 -0500
Received: by gyc15 with SMTP id 15so3272293gyc.19
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2011 12:29:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EBD73C8.8070407@redhat.com>
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
 <4EBD73C8.8070407@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Nov 2011 13:29:32 -0700
Message-ID: <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
To: Don Dutile <ddutile@redhat.com>
Cc: James Paradis <jparadis@redhat.com>,
	Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 12:13 PM, Don Dutile <ddutile@redhat.com> wrote:
> On 11/11/2011 12:41 PM, James Paradis wrote:
>>
>> Hmmm... would it be better to do this as a quirk or as a boot
>> parameter?  I've heard reports that other systems may be running
>
> Hearsay?  if you have definite cases, then please share them,
> so folks know when to flip the boot parameter on.  note: it would have to be
> an early boot param as well.

It'd definitely be good to know all the specific cases.

But merely sharing them so folks will know when to use the parameter
is a broken model.  We should make it work automatically, either with
some sort of machine-dependent quirk, or (preferably) with a change to
the generic algorithm so it can handle these "broken" topologies along
with all the correct ones.

Bjorn
