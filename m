Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0938887C
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234393; cv=none; b=eOw8BorKIp508ykwzsChdLMYg6BFats1a9wOz7lvDTmsD2nBes5ecKgAlDMVDLzBgil7B37IVDEH7YNPxfwrbFNVeLnOKAmPA5jAhQmb/gqGzdoi+X9axiSEaF7Hm503A+Uvs6B32N1fcxuDiy3kZh6ybYzW8z3tmi7J064RE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234393; c=relaxed/simple;
	bh=+OWC+hm04vkx07o8SXbdOwqEuj7KIn2R19JW3xoiy38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4lwapl5vZ84U8+GtWippgjbQYkJYDBa4qkDr2WE1OY6iXLNScD72XLBF7XFuB6BUsKrwVTkpDZGvgfZbRTiyZDmR35a8eMnsKdRNoz8bkLV2hSdoq/qeTuHZJQhhl7AKXpFljv4FM0GzQ6RsP+28VHs4QsGSNhHmRwKrvcEHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+DkanMj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+DkanMj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso1355ad.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782234391; x=1782839191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tu79wS1tW2o86htP+jh+vF6ThoZY7vyXOnOxpMqA3sM=;
        b=L+DkanMj6u77QinnAxK6Me+oFF8nlz5zws5eq5nAheNpQ1bBkVbX26JFJHcEjGRSBh
         dbkZFOxh/x6A+Tbw/GiSy6h0Ob4KPgZXxi/ih3aFgpchzQgv3/hmelvqE4VnChsWcQww
         bxNHnof2vcau+gyp3y19+Sg4CwHU1r9cAEOdbfUYD5W9TRWHBS0SO2KI5iTjTxaOU+ub
         WaEYFLSadXDvVoLSq9JKjJGeFmxk6ixLQacJ2VqOtynI3plfOFU/uH1VHYLyS9mwNoER
         e19LfYU8tfxu4CdEg6vYXjCIdWZEgchJ+YuqmsgUJOoidPPFnAy8QKPA4hV2JlRKgY9H
         il4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234391; x=1782839191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tu79wS1tW2o86htP+jh+vF6ThoZY7vyXOnOxpMqA3sM=;
        b=q89Rpbcj9hqdJiQUu4BqWABGmXsX+DrJbYgofA7STTMC4Ms3XFBiLJ7oKHrMn1+PRC
         MVU3zsYH6EeY+R2gccmS1+JeOQBgbIYk1R0xVvHZE8AolHi6DDRA7On4uFWipbY/8ksn
         hdrtKgee7+F63nKoT9Y1j/CMIfswM2+/RBE+gY/L/59UGl47z70rjzDukebPSsK7hFqw
         +uKRQKffjr0YRVq4WmFGhzV8GYBwvn3+h9pktjaN2SVAQbL7xCDhoj0ReiiLdhDtmGJc
         bnmFjwPooya54mCrOGxXiLJs0ZwRIBbcFTwhnTgyonStOsigMX+CCkwlANFV8WLpCicH
         SAaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2F9TFkVxOseG04KAwFDPjjVS8GyGjdpqwPcef58iTMs2azGWa6zxP84jiFV82QkLeymvoAe2krQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIpHWZYy7ozV8Ok7XbPb+ZcHlAGGvvjwylUill4EnxqWseG1w
	tAoShRERis5dOrF9gfvIwmqZ7wsoiIh7PwGOAnU2AxWg2dYpWW47H9txh6hdHA1rxZ+0LrIa7dt
	eICfxqopc
X-Gm-Gg: AfdE7cnW/QxxeQ7uxfmqUi0aQAhjy8KVesbjq3dNrb2lS+bQoQKJXs92LRs8dFrlpLF
	ibprpfCvxzRhqassGdfCAqVZ4pYKknglLI3HwOcyaGhRrhF/yaLJLudv5hajRurrC5DMBmCm6A1
	aD4YL2G2dWLWlY5z4CRimiZy6JK5b/ah1lGjPq8qgF5Cv/+L0OHIkDXNsmWCk8uI4/ccKnYTCZY
	x8L7ME8Wewjx/HPcuejH9gSLa26j/wkQv1HC/YieYbnkOwJD3vVyJ22J12nBz8KV8J3+Y/Di1QM
	rb5WSMQ3OpbukTBFDqptzrvgFMBIrErqffXxOq6w6JWqP2dNcTZLH74eQcN+M2fnOW6V6w07Y8z
	MEecxWEr2eCxO0MCYNcbJYZ7PFS2vhYE6+4eStrVjXW1mWSZ3CQN5wLpfy/UbyGMY7I2bTVmUiZ
	4CUu57/B/7/O126QUzi5N3p+Y+d3UVoQsLrCSLVZ/5dmbWJxLR3MFwB6/k9ENpWzJkRCP9lYRwH
	ZIvZ809
X-Received: by 2002:a17:902:c404:b0:2bf:749:55c with SMTP id d9443c01a7336-2c7c711c2f1mr2378745ad.21.1782234370647;
        Tue, 23 Jun 2026 10:06:10 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af54dsm113990285ad.11.2026.06.23.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:06:10 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:06:07 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <ajq852qLegjfkP4d@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
>During a Live Update, preserved devices must be allowed to continue
>performing memory transactions so the kernel cannot change the fabric
>topology, including bus numbers, since that would require disabling
>and flushing any memory transactions first.
>
>To keep bus numbers constant, always inherit the secondary and
>subordinate bus numbers assigned to bridges during scanning, instead of
>assigning new ones, if any PCI devices are being preserved. Note that
>the kernel inherits bus numbers even on bridges without any downstream
>endpoints that were preserved. This avoids accidentally assigning a
>bridge a new window that overlaps with a preserved device that is
>downstream of a different bridge.
>
>If a bridge is scanned with a broken topology or has no bus numbers
>set during a Live Update, refuse to assign it new bus numbers and refuse
>to enumerate devices below it until the Live Update is finished. This is
>a safety measure to prevent topology conflicts.
>
>Require that CONFIG_CARDBUS is not enabled to enable
>CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
>bridges requires additional work but is not a priority at the moment.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> .../admin-guide/kernel-parameters.txt         |  6 +-
> drivers/pci/Kconfig                           |  2 +-
> drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
> drivers/pci/liveupdate.h                      | 14 ++++
> drivers/pci/probe.c                           | 17 +++-
> include/linux/pci_liveupdate.h                |  4 +
> 6 files changed, 119 insertions(+), 7 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
