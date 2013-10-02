Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46938 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3JBTKi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2013 15:10:38 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so1314738pbb.14
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2013 12:10:37 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Oct 2013 21:10:37 +0200
Message-ID: <CAKqeN2-uu9sV5g7LpTn-E8osOf1L3mi97FnA1Oi6YJAs8POBCw@mail.gmail.com>
Subject: override B:D:F assignments for SRIOV VFs
From: Andre Richter <andre.o.richter@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

i have an SRIOV capable device which has its PF behind 01:00.0.
After enabling SRIOV, the VFs show up as 01:08.0, 01:08.1 and so on.

Due to several stupid reasons, I'd like to do a quick and dirty hack
that makes my VFs show up as 01:00.1, 01:00.2 and so on.

I'd be so happy for any hints where to start with this.

What I found already is virtfn_devfn() in iov.c, where the devfns for
the VFs are computed, but changing it here doesn't work. I guess this
has to be done way before?
However, I wonder where the rule for computing the devfn comes from?

Thanks, Andre
