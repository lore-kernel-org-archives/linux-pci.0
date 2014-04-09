Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52317 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbaDILc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Apr 2014 07:32:26 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so2527887obc.28
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2014 04:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcvp5GwigUPS_x+aq6BSWDQF_J6wthPL1H8FrVx_DR03rdmOA@mail.gmail.com>
References: <CAHH3p5LwsWqtK_RhaYNKi_HeNYH3EHrgXV21SbRTA4mm2Vyjwg@mail.gmail.com>
	<1396538590.3215.6.camel@ul30vt.home>
	<CAHH3p5L6BO0PfXG_pB18-Tt1waLEL6bDV_=-1wR+afeQXHGh=g@mail.gmail.com>
	<CAPcvp5GwigUPS_x+aq6BSWDQF_J6wthPL1H8FrVx_DR03rdmOA@mail.gmail.com>
Date: Wed, 9 Apr 2014 17:02:25 +0530
Message-ID: <CAHH3p5JzELcCam0EvauS1qouC9hhAa5zhin8=vG81G3-Us1_vQ@mail.gmail.com>
Subject: Re: Writing to BARs of PCIE device
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Andrew,

1. I am looking for some kind of stress test which will stress pcie
interface links independent of device so that no device driver
required.
2. Stress Writes(which write whole BARs space) has above issues and
seems invalid.
3. Will Stress Reads fulfill my purpose? Or any other ways?

On Fri, Apr 4, 2014 at 5:27 PM, Andrew Murray
<amurray@embedded-bits.co.uk> wrote:
> On 4 April 2014 07:14, shiv prakash Agarwal <chhotu.shiv@gmail.com> wrote:
>> Thanks Alex,
>>
>> 1. I am not concerned about device functionality but need to verify
>> PCIE interface only by stressing it.
>>
>> 2. But I don't see writes getting reflected for most of addresses.
>
> That's probably to be expected - You are treating the address space
> provided by the BARs as RAM, rather than MMIO. It's entirely up to the
> endpoint vendor to determine how this address space responds to reads
> and writes. You'll find that the address space probably consists of
> registers, some of which will likely be read only.
>
>>
>> 3. Also very often, it hangs in middle with CPU soft lockup and rcu
>> preempt failures as below:
>
> This may also be expected. The endpoint may consider some of your
> reads/writes to be invalid, e.g. writing to a read-only register,
> writing/reading at an incorrect time/location. This may result in the
> endpoint raising error messages or even failing to respond to read
> requests. (How do you know that you're not telling the endpoint to
> stop responding to subsequent reads?)
>
>>
>> [ 9732.090081] BUG: soft lockup- CPU#0 stuck for 22s! [update-notifier:1319]
>> [ 9742.108839] INFO: rcu_preempt self-detected stall on CPU
>> [ 9742.108848] INFO: rcu_preempt detected stalls on CPUs/tasks: { 0}
>> (detected by 3, t=366016 jiffies, g=88556, c=88555, q=2037)
>>
>> 4. So query is why above 2 issues? I know it will affect device
>> functionality but at least stress write test suite should work, right?
>
> Only where you know that the BAR memory for your particular endpoint
> is designed to support such behavior. I can't imagine that any off the
> shelf device would.
>
> A better stress test would be to plug in a load of network / SATA
> cards and heavily use them.
>
> Thanks,
>
> Andrew Murray
