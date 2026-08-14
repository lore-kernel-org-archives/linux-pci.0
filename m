Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB13D093E
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722858; cv=none; b=gQ2ihxQIF1Zx0Uv46aOZYrjbbJ8o/zIYTDGykUYM/tpXoRHNh/0npn/TiNW5LAnU93CnySFv204quWJNsY+xxvJzurHchXlnC6kcNh+H/yiB6sB3hDvv/AQD8PIY03Xg7ByeRzsPRjqlMpfZN0l6D+jOPkSaTUFxXbboc6ngcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722858; c=relaxed/simple;
	bh=LR+F9o8z2ArdQWgZKBLhQR4M24y5KNqH0Azx9MV4D8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GomXMuLPpREvMnzKEW0BgNCPgdO3Ep9TJjlKHZMH8pnGFDbZI34PdRU1e0EJBvdLRC+NykIN6W06rSSuKabpw8Y/Sg8+deE5XHkLCj+BlG2V2r4E9pUwHbiElQek0TnD3s58rW23X8rZtNiPHZfiSfdB4/updudZtlWGn5TtlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEIVV9pU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEIVV9pU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccdf36f63dso127055ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786722856; x=1787327656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi8lKrsPGjtKjHhLvrK6PemQZweWipGEphM9Nz2AqhE=;
        b=YEIVV9pUPKE2x6YeYaLvUUzKEPJlO0A9rjECyiCfQMPJoR8fwZtulyUE9Uo9Lnx3yd
         f47HpH8fcQ70lGK3aizYikdheqRiCq2mOmRBlcZitRx46bXsTH+wTqYRZi5bqd8UolOL
         ic47SUWC6EZY61rIUfa8IaOyziXSsqjIXYOg/xc3k6D1pmPYKudpSCHp6Mfl34D5LUV+
         xP65EcPvW4m4teWZhDVXTfD96kZay9n61WdRRq4wPXo4xwNUFbVujkQcIR8TmnsB8Hw8
         Ux4eSjacxbqXmlxzZGa944Hp8fb/U8NIHZR8rdI8szkDp9W2jHlypfF2rRGr04g6M23n
         2nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786722856; x=1787327656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi8lKrsPGjtKjHhLvrK6PemQZweWipGEphM9Nz2AqhE=;
        b=GepcM/nr69W93bZ9s6BmjZJfvgjuMsxyBMhgYHsoGjSliWeHAsNb1236T+4pwsL0Tk
         O9xhW96hMq6aPrU/zTXDJNwYBHwj0Z5LtDHlBz2M4RJ9xoifToT8zckFE2fBb9Qpd+Nn
         FqOoTL9jDDlzbxSBroQEHcNn6y7pgQhb3t507glDGS3YKeRCEIpVEQOzEgRWN/lIGaBa
         C7XPm+hrFJ0rrjn4DNBKEwb6bphErgv1XqbdHCGCb+2zHOUdwwhes+8jkCJOkrx4DSlE
         NnADmkj7kvZTWBa/th59lEqghj6hf/Ho0giry02OXtYvqpqxt9vCR7GF6ScZnO/MfYGJ
         bgww==
X-Forwarded-Encrypted: i=1; AHgh+Rpt31IiPp6FqJlh+In9avmMHzZ3eERPX8kZT8TgCaUQDruOk+9u7IPg+A02WrJcmW+e6ovTaVjZGRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3wHcvqEal6hbJtE8scP1lLk8cltR5CsEmm+cUA0wjQEjJutc
	uY5U9RYXsjro5ZZAkZPgWQ4WcUTaIgP5lw0+Uap/+6fgonB3ph/c7MQ5Uhze94xZWg==
X-Gm-Gg: AR+sD12A3NSi1EqI/14YqegMvHbfMrFoLk6DaOJgdcoZSNfHSUwh5lNBhHNmr9zZvda
	L1EkV4xeJeEL+5RPSk8n15gjLqIdEsg453tyqwCnNKDICpVG17EgiUmFLLkfIFWcQlnJNUKLh8h
	4zIHAK9Vj4lCyPKL6FpwwIhIMEw0opFRUVPcjKKa1Xlqnu8IQL8eQgI7xuo2b/N61T7SovFA7OV
	x5y/lc5h+0oPr7RxxBsW6pDeYMZq+JmJ63XN5PcIR/nZnBqsa7ZzvMs0k5DNZJZd5EKnXNOHkBh
	Mg8mZq07FPbuy4x0LAJoVNzxv3bkn2tb0DZg+VlnQs1CkD6zJ79MTzr10tNzs9t/iCIT0IZaZnP
	7eygU88RJS69dc7KaxKqBF1FTbm6kQGUYRWYX1AdOXx78Z2OvhtyhETf5yn+i6pL6AdHucXF0M+
	NxqbciQIKJMP7RLF+geC9QZ9N2zJQwPPRYHs53/Z7nAMvZvSTatifFjEoFQilmMIWU0iM3oCOPe
	s9/O6+hi4hf9EIkyqlQQpEif5p46Ms/s0FyCYIetfyBTEtgeWf4Q0ph3XE=
X-Received: by 2002:a17:902:d58f:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2d3af24fe17mr9846895ad.10.1786722855608;
        Fri, 14 Aug 2026 08:54:15 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm1779979a91.1.2026.08.14.08.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:54:14 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:54:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <an81s9PcW7OFVj8M@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814083737.66bb83fb@nvidia.com>

On Fri, Aug 14, 2026 at 08:37:37AM -0600, Alex Williamson wrote:
>On Thu, 13 Aug 2026 23:22:33 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> >

[snip]

>> >+	if (pci_num_vf(dev) > 0) {
>> >+		pci_dev_unlock(dev);
>> >+		return -ENOTTY;
>> >+	}
>>
>> I am wondering whether we should return EAGAIN from here, since this
>> function is used by vfio_pci_core_enable() during open and it doesn't
>> fail the open on ENOTTY. Basically whether we should allow the user to
>> reopen the device if the reset was skipped previously? In the previous
>> instance of open, the device was setup with vfio/iommufd and the vfio fd
>> was abruptly closed and the reset was skipped. But the device went back
>> to the IOMMU default domain and that is probably an Identity domain. If
>> we allow the device to be opened and re-enable busmaster without a
>> reset, is there a chance that device would continue to DMA based on its
>> previous setup/context? Probably unlikely?
>>
>> Note this is different from the current vfio-pci behaviour where device
>> is always reset during close.
>>
>> Maybe thinking with too much paranoia about it :D.
>
>Devices are only ever opened into a user owned domain, the IOMMU
>context switch happens before this and regardless of the reset.  Close
>also disables bus-master regardless of reset, so there's no risk of

Yes the close side makes sense, I was more concerned about the reopen.
>ongoing DMA if the device is placed into an identity domain between
>close and re-open.
>
>Actually, I think -ENOTTY is a leftover from a previous iteration where
>this test was pushed into the individual reset methods.  -ENOTTY allows
>continuing to the next reset method.  With the test guarding all the
>reset methods in this version, we should probably use -EBUSY.  -EAGAIN
>would conflate the try-lock contention error, which is actually a usage
>race, versus the PF is not in a state to handle the request.

This sounds good to me.
>
>If the user owns the PF, as evidenced by them being able to get to
>vfio_pci_core_enable(), and reset is blocked by the SR-IOV state of the
>PF, I think there are arguments both that the user implicitly opted in
>to the best-effort reset, as well as a use case that allows the PF
>driver to fail and re-open the PF demands this behavior.

That is fair.

Thanks for clarifying.

Sami
