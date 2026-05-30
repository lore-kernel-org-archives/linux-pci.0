Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA31A9F97
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101320; cv=none; b=nVD6Agk0H18fDth2Iw+oTTYWtQ+9xSFVIC/y7lJ0HyqaqjlhpJidlmJ9cgs+qr6jVs5oxH2nspw0BQmBU/iVENGKS0gvDju5FJwYgX2+7JlpztjrVDhB1L5jQ6qKKaWLeZrRrB5UJ5bfGVd4nnhNSgq4Wl4RSzXoHm5Ili89uME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101320; c=relaxed/simple;
	bh=p9VB8mi00fhJHvqbkWD1f5hU4430riMH379SGSdgcRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br38oM2c/eGsF7AYc7CxRQNFYJOZvVCr9HcsYRxcK4buvDd/vlSTlmVqCtGTlP7jGJ8bYWLDCA3j8VmtT7mcsSTfyl8G2Ecss5UmZUx1Y+1IlWmqTXLgZxm2Tt/TK/si69oDbOm8ij+jfG+jojDUdSxB7GfNx+i27i39ZXxJzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZWzPaRCH; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZWzPaRCH"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304ffa40c5dso807429eec.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780101318; x=1780706118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFuLdZPUcaeYfp9j7gX4E3uZ3myAQG0aKak+9UAYUik=;
        b=ZWzPaRCHH1VOicTBABqDhFwy2i7ztGHfndQjMpX2cKdXeOjqQ1Z9Y6HbvRSw548bXn
         ZMZEDd/YC9Txp1QHEr9xa4W5o8QuP7vHMulXmiSiEaSypmHAA9EjGW9YVLsqHF1iayCX
         TLVFgj4yjq4nHdX3OoHqFVKQmpIIohyKbb4QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101318; x=1780706118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFuLdZPUcaeYfp9j7gX4E3uZ3myAQG0aKak+9UAYUik=;
        b=DjkU0UyRJot8q2FsyzscpoMQ9PgIER8JLORBMEY77bxiSdMI7ZWA4OZSHMASllc1mj
         4Xcm5uDIyN6WM+eb9J5YIDXndHQ+z7K6sMJ4Vl2Zb6KfpBjTz3HHhnYPnL8gbTHC4N0g
         9oryQ4da7Wz1xJRKjSMB7ga5MKvqsDVJeIyy2q8Ksn6E659j82djda7EIhDFmWwLG6B9
         S6s5L4wk/NCu/8XvTjz6N/chj3Q9+oKQaU5cAlhtBvHPdqHLjJgs7/AYlQsM2K9+Lxok
         LQHrRQ5dt0WCUzKdFuwMqCp/94Ix4hV7xy1PHyNTu8Tcj40QzFTpvo0BFIL/EbiqM3Gw
         f8zg==
X-Forwarded-Encrypted: i=1; AFNElJ8XEKZAhWzMwA4NRbeE2wPS5CHeftej2jhnahCHxjL2fH6RyCE1eK0wDxXEkHQKj/343NMlTi6T+DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoEOV2Fb4xargx1NJO+fF0VbfCANUsmzfvwmRmAHU7ZmJvhua
	ctgItmxhPuX6i9RG5BJlT7TF/ziucfo4QZDtF4/o5So94YvI67JlwCtpddN21b/nWA==
X-Gm-Gg: Acq92OEWPsMUWO5TgzsBdK3sgM2RTz1/P+YWiQkKYow4OMcf6A1kr+G6vPY53kucKst
	kC8UkkYDTg1mQvqPGNbAef6ZgnFtUZAb82xBK3hfWtrZcAsjQ52Td/IwqPXLWSCWd2XHFn3G0cT
	4U9FFZMQl6muqTtZiwKt9/pXcUIor1hLfGxSnl6JPT4PMLCu70tztcalVOGiSBxrsQeDMPK2XQ0
	J9VMcTw16sr6RFN182z0dOyJq3OEYlFKjT5zbg4pIhhTCTY1JRhJbQ080RGB7vJTDRL8FXfivxz
	PDd3GM4ipvgWvU+LBr3u5WDWVaQpM/rR9YtwnE5tN0c/+iUC3wU37pzMYmyLz/w04RqErSWXWgO
	oydRHKBAEEF5ccMFGRr4flnce2P8TLea2oLPagBFFyUfubG+hf1UItixMcFA3jmGvhyVfJMXIDg
	C66uTGDRE6jHwREJTtqT+wNfHV85syfYWs9ssfW8zP3KAJ4DhlqFqqb069wkUc/Fqgu1FHe1Pk
X-Received: by 2002:a05:7300:1899:b0:2ed:e15:c925 with SMTP id 5a478bee46e88-304fa695496mr1024072eec.33.1780101317945;
        Fri, 29 May 2026 17:35:17 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:9fdf:e1c8:e808:b604])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304ed5d26d1sm2732316eec.30.2026.05.29.17.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 17:35:17 -0700 (PDT)
Date: Fri, 29 May 2026 17:35:13 -0700
From: Brian Norris <briannorris@chromium.org>
To: Radu Rendec <radu@rendec.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Tsai <danielsftsai@google.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <ahowweKTZXteLgZS@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <ahC8Pyuatu_AvnZp@google.com>
 <ahDvvGew5UK3KSpi@google.com>
 <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>

Hi Radu,

On Mon, May 25, 2026 at 12:48:09PM -0400, Radu Rendec wrote:
> On Fri, 2026-05-22 at 17:07 -0700, Brian Norris wrote:
> > (Updating Radu's email; dropping another bouncing email)
> 
> Thanks for doing that! Obviously, I no longer have access to the email
> address that was used to post the patch, and I was lazy in setting up
> scripts that follow the mailing lists to catch messages that are
> addressed to me directly but using old email addresses.

No worries. The email bounce notified me rather quickly, and in the end,
you saw this within a few hours of first report anyway :)

> > On Fri, May 22, 2026 at 01:27:43PM -0700, Brian Norris wrote:
> > > I'll see if I can learn anything more here on my own, but I figured I'd
> > > report it in case you have any thoughts or leads I should investigate.
> 
> Thanks for reporting it! I do not have any thoughts or leads yet, but I
> do plan to look at it during the next few days and hopefully come up
> with something. I also apologize for the slowness in my replies.

I'm only getting occasional time to spend on this too, so I'm a bit slow
as well.

> > In an hour or two of poking, all I've learned so far is that the problem
> > also seems to go away if I:
> > 
> > (a) add a few dump_stack() and other noisy logs to a few key places (for
> >     now, __pci_write_msi_msg(), pci_power_up() failures, and
> >     irq_chip_redirect_set_affinity() -- I think __pci_write_msi_msg()
> >     was the most significant, possibly because it produced the most log
> >     text) and
> > 
> > (b) leave a 115200 baud UART kernel console running.
> > 
> > (This is on a sample size of 20+ suspend cycles, whereas previous
> > bisection would fail 100%.)
> > 
> > It then reappers when I quiet the kernel logging a bit with `dmesg -n3`.
> > 
> > I think that simply tells me that there's some timing issue or race
> > condition involved.
> 
> That's very useful! Interrupts are migrated on suspend to the main CPU
> and then migrated back on resume, and the ordering and synchronization
> around that is tricky. The stack trace in your previous message tells
> me that the nvme driver is waiting for IO completion, which is normally
> signaled by an interrupt, except that interrupt never arrives.

That's true. But the first failure is:

  nvme 0001:01:00.0: Unable to change power state from unknown to D0, device inaccessible

That means the PCI config read of the PM status register is returning
all-0xff, so we're not really able to guarantee the NVMe PCIe device has
powered back up at all. In my experience, that's indicative that the
PCIe link has failed in some way, or the root complex is otherwise
misbehaving. If the link is not functional, we won't receive any NVMe
MSIs.

I still can't explain what about this patch is causing a PCIe link
failure though.

> With my patch included, the demultiplexed interrupt (the nvme interrupt
> in this case) has an opportunity to be migrated during suspend/resume,
> whereas previously it did not. That's one more moving part, and I'll
> have to look closer at the code and think what could go wrong. I agree
> it's likely a race condition or a timing issue because it works with
> that extra logging, which adds small delays as a side effect.

I also tried hot-unplugging all non-boot CPUs before suspending the
system:

  for i in /sys/devices/system/cpu/cpu{1,2,3,4,5,6,7}/online; do echo 1 > $i; done
  echo +10 > /sys/class/rtc/rtc0/wakealarm
  echo mem > /sys/power/state

I believe that means all the affinity/migration will occur while the
system is fully online, so we're less likely to run into power
management race conditions. In this test, NVMe is still functional after
the first step (CPU offline), but it still fails after suspend-to-mem.

This seems to tell me the irq_set_affinity()/migration process isn't
really what's killing things, but something else.

Brian
