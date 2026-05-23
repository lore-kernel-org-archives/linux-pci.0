Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9AB640
	for <linux-pci@vger.kernel.org>; Sat, 23 May 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494850; cv=none; b=CxCNjGsDlqBzmVFhqxYyaF47YpcEkg5XDAt/h7FOMkenAQnjBu1nCrGjw3bYe3On4rECgn4N1wTZVrH5QTmDYOVS9p3e2GbFuE83yuAnoAQXRWQFZc4Bob7kHTWSmIkj/20xzUXcWqnoBMXz/pPtK1JK2A9EWUNgx8bQvv48zLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494850; c=relaxed/simple;
	bh=U6hfL30wCkaOPoFd0mY8v1bZog5Vt18CTzOmDtwR1b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3ACTE2L+bvoCqM3zWWLTkbIpMOK2VDEFP1LrOhfu1AXL/E4GgGCGtR+OrCcl/KmHCDj6kOP+wFl43qojDSmNQKrnEHL87ObBeGl+lETTwEz6F8/T7hnha6Re6b0qmDJ23xko0lM5HTEM4ULqjXPhHBQvrPBOYAHCf88IXcW/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bt4iwT1o; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bt4iwT1o"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1353c2f35cfso483023c88.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779494848; x=1780099648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgKhRtM90YnNHveQxPiSsyQQXIo0bs1pSqGccx4scGo=;
        b=bt4iwT1oLLypF7Pn31CpTx7VpGRButxWSXx7tznDnbBYSaiv1ol5eEnREV+1L1GETQ
         8SPYVuQvAhUpXxdvfaflKgC5BNs7EuADpT+o+UNeEb9dWcq8H7rT/lgkdrBeeIwN3JkW
         jOhAXdjlJDkUvF2S9cp5Cc2mSHvZlzDDPY+OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779494848; x=1780099648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgKhRtM90YnNHveQxPiSsyQQXIo0bs1pSqGccx4scGo=;
        b=ck+onG+O0+NNdGHtNetNwologoUSdq2RiO3tdJdlXJfGQQ+zxdfCL3DQjUECmP8juY
         RhU5y3Xuatoc3mIzKNGmPNyeYXA5Ixm67mOKWxUfsjnAKNtRGFuDY54GZjUizJsBKjqA
         dp8xUv0Q2GaOPAYUsUzuI3+Ap+G4zW7Ez19H3/58j/gv3OMXNyoVU8uqphhPUYCE9bJk
         RiGC0SSwHl2SUbEPn2MSPKOgkoXEh4tPhkT7JB23XW3C/zeKpkkvcMrWz2JU3xQmU+uI
         MPKM/TNfgVJd+b+NUF1+l2FPUtP7eIWk/4yg5kDlJUIbJuC30VQ8of6OwGYIjjfg7SxG
         Cabg==
X-Forwarded-Encrypted: i=1; AFNElJ9SdGdIrzpauThT+2fMz4Wzw/ZZZjx4tqsh6eA1SfcLSIGE8MVehweooMn5H8FwYuEtlyBYhzwB6Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzY5e+Ni/PEmuQhFj4HLAjOmWLejAX/WfPzcs1L9/bjGcvBsb+
	bRMFtDcQjFtkLAGNQS0K8BqJi9kRPvctq+UKxZ6+f7h5JydEJOUdrSO/V3LQROF0ZQ==
X-Gm-Gg: Acq92OGsH2+sd5uzUZz5tH3CxgQE5fW5LqGNvemvpTEhl/wOwfLZVrkJBsOV/9b/uPs
	vzjLQLWjdya0KeRLPXXvWKU0pm3HJN7IIYN9DFUSTLnjAeHYmI7B9i3bKgaQk95+B4aVV35RRwo
	UEgoEOAai1mAO6OwLAQBwGxbaxNDkz1xZIBGVH56KSnaVmBmS6YgrxUYZAuJkOoX9gHjnZBMvJG
	ppCEsy9dnOCYKf9UiNE+/yazyiaBXOHbciwRLTXPrLTYN62lptYNdPBwaOHiaVVnP2UPkyf2Bs5
	tKV2nCFG2N14ABn/yxvRxWeWK/8H72GlMUxpMMSldIcZX/DITO7a2jDQMHFgVOFeBjsUjtIb915
	iy9ek0+XNl+pN9C5ttG6v2znCXCB2n4lQ6xk7Z3+1e6McebOGFFqgQP+g40DoR2MjUiggVabW9v
	ppUz/xFbJ7rtYz0pufJgJjGNEdsec8jYGH4iWLaPcfgouylOebnlACPM8KjG5VDbCnFxE3KXew
X-Received: by 2002:a05:7022:7a3:b0:12d:de3f:d843 with SMTP id a92af1059eb24-1365fd7e4a6mr2462351c88.38.1779494848253;
        Fri, 22 May 2026 17:07:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:c51f:b7da:e920:bf64])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1366a4011d9sm2122398c88.6.2026.05.22.17.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 17:07:27 -0700 (PDT)
Date: Fri, 22 May 2026 17:07:24 -0700
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
Message-ID: <ahDvvGew5UK3KSpi@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <ahC8Pyuatu_AvnZp@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahC8Pyuatu_AvnZp@google.com>

(Updating Radu's email; dropping another bouncing email)

On Fri, May 22, 2026 at 01:27:43PM -0700, Brian Norris wrote:
> I'll see if I can learn anything more here on my own, but I figured I'd
> report it in case you have any thoughts or leads I should investigate.

In an hour or two of poking, all I've learned so far is that the problem
also seems to go away if I:

(a) add a few dump_stack() and other noisy logs to a few key places (for
    now, __pci_write_msi_msg(), pci_power_up() failures, and
    irq_chip_redirect_set_affinity() -- I think __pci_write_msi_msg()
    was the most significant, possibly because it produced the most log
    text) and

(b) leave a 115200 baud UART kernel console running.

(This is on a sample size of 20+ suspend cycles, whereas previous
bisection would fail 100%.)

It then reappers when I quiet the kernel logging a bit with `dmesg -n3`.

I think that simply tells me that there's some timing issue or race
condition involved.

Brian
