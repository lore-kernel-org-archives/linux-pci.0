Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbaCEIXf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Mar 2014 03:23:35 -0500
Message-ID: <5316DEFA.8060600@redhat.com>
Date: Wed, 05 Mar 2014 09:23:22 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>
Subject: Re: kmemleak through e1000?
References: <5315F785.4050602@redhat.com> <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com> <53164BEE.9060405@redhat.com> <CAErSpo54aGGbqGG08bOWCor3xp5r=kxOXm0wp27Lyhr5=qJRGA@mail.gmail.com>
In-Reply-To: <CAErSpo54aGGbqGG08bOWCor3xp5r=kxOXm0wp27Lyhr5=qJRGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/04/2014 11:49 PM, Bjorn Helgaas wrote:
...
> Thanks, Daniel.  I confirmed that the two MSI fixes are not in the
> tree you're testing, so that's probably what you're seeing.

Ok, that's great, thanks a lot for the clarification Bjorn.
