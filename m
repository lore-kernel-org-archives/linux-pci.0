Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38136 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaDDGOi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 02:14:38 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so3080223oag.22
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 23:14:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396538590.3215.6.camel@ul30vt.home>
References: <CAHH3p5LwsWqtK_RhaYNKi_HeNYH3EHrgXV21SbRTA4mm2Vyjwg@mail.gmail.com>
	<1396538590.3215.6.camel@ul30vt.home>
Date: Fri, 4 Apr 2014 11:44:37 +0530
Message-ID: <CAHH3p5L6BO0PfXG_pB18-Tt1waLEL6bDV_=-1wR+afeQXHGh=g@mail.gmail.com>
Subject: Re: Writing to BARs of PCIE device
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Alex,

1. I am not concerned about device functionality but need to verify
PCIE interface only by stressing it.

2. But I don't see writes getting reflected for most of addresses.

3. Also very often, it hangs in middle with CPU soft lockup and rcu
preempt failures as below:

[ 9732.090081] BUG: soft lockup- CPU#0 stuck for 22s! [update-notifier:1319]
[ 9742.108839] INFO: rcu_preempt self-detected stall on CPU
[ 9742.108848] INFO: rcu_preempt detected stalls on CPUs/tasks: { 0}
(detected by 3, t=366016 jiffies, g=88556, c=88555, q=2037)

4. So query is why above 2 issues? I know it will affect device
functionality but at least stress write test suite should work, right?

On Thu, Apr 3, 2014 at 8:53 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 2014-04-03 at 20:38 +0530, shiv prakash Agarwal wrote:
>> Hi All,
>>
>> I have a stress test which write a specific 4B pattern to whole BAR
>> space for all BARs of a pcie device.
>>
>> Query is:
>>
>> 1. Is it allowed? Or will it have any side-effects?
>> 2. If No, is it not allowed for all BARs or some BARs only like BAR0?
>
> Of course it will have side-effects, it's conceptually the same as
> 'cat /dev/random > /dev/mem', but for a device instead of the kernel.
> What you're overwriting is device dependent, but in any case you're
> trashing something.  The test sounds completely invalid to me.  Thanks,
>
> Alex
>
