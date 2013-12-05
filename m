Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35130 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739Ab3LEUkY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 15:40:24 -0500
Date: Thu, 5 Dec 2013 20:40:17 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Aaron McSorley <a@aaronmcsorley.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Message-ID: <20131205204017.GR31504@decadent.org.uk>
References: <CANN5nGKvaHCzWKMNyUhNfSfTfZBcVxG9RfeuQaOAFS9TghF=0w@mail.gmail.com>
 <CAErSpo6SeyZpta+MuB5EnS-Rx80bAYmLkCaQgt5q_jgbtL4X6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6SeyZpta+MuB5EnS-Rx80bAYmLkCaQgt5q_jgbtL4X6w@mail.gmail.com>
Subject: Re: error loading iwlwifi on sony vaio
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 05, 2013 at 01:20:13PM -0700, Bjorn Helgaas wrote:
> [+cc Jiang, Ben]
> 
> On Thu, Dec 5, 2013 at 8:24 AM, Aaron McSorley <a@aaronmcsorley.com> wrote:
> > Hello, I'm getting this message when trying to load iwlwifi in our
> > debian live image running kernel 3.8.5, this is on a Sony SVS13AA11L,
> > please advise on how to debug this, or any additional information you
> > need, any help is much appreciated, and thanks in advance
> 
> Thanks, Aaron.  Can you collect the complete dmesg log and output of
> "lspci -vv" (run as root)?
> 
> I know this is a Debian kernel, but the upstream kernel likely still
> has the same problem, so it'd be good if you opened a bug report at
> http://bugzilla.kernel.org (drivers/pci category).
[...]
> > 3.8-0baureo1-486 #1 Debian 3.8.5-1~experimental.1~baureo1
[...]

This is not a Debian kernel; it's a derivative where the distributor
name has not been changed (maybe I should make it harder to do
that...).  The only patch we applied to iwlwifi in version
3.8.5-1~experimental.1 was:

http://anonscm.debian.org/viewvc/kernel/releases/linux/3.8.5-1~experimental.1/debian/patches/debian/iwlwifi-do-not-request-unreleased-firmware.patch?revision=19961&view=markup

There could have been other changes by the derivative, but probably
not.

Ben.

-- 
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption] would be
development of an easy way to factor large prime numbers. - Bill Gates
