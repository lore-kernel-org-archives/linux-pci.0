Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549669;
	b=ZAVVPX5/Zi18sbfT4yhTjOdI70pCiE1s1HGXMfScIzZniC9hbMfadYeK8s8VjsjbBTaY
	 RpzrALtKCIm7G1tnLYIyoG5+zdPSarh0MPkASxnhC4Zj3BHXVWCCKXmbVIoTD0afIt8Op
	 Xf2YUDb0NGeEXEHIZXgNwBMiJrw5cFJOG5t1gYMY4LYHk6yM6aKIdl4YD8cTut87EXYeV
	 WBlzEkiJ/JVS/aQ9jt5FnbP+QmX7+33thsy0KJFHERiECZnnaGAfMwOlb3cgrqa7AghAp
	 E/fFKafD0edLdaJQ6vn9kmn/zFRlYJ4FLA8fUKy1lQYBrZvA1FCih+dq+JB+aochRxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
	b=U3lC4monLNYNwRBZpr0Uc72N3FAwJ33qTZ4ibtPGYy5hqtixvX6apq/bs0l45mGSXjlU
	 dbCTuk4zx7GHRzd6e0F5N55V0dtaa/t3bQJzJNdXYYzI2f4v6qN4b3APi1dhchRFe5SWH
	 tfLLIQuvp8LXLT3TXpxAt/qyeqDS8mkGS/LDQovlXQjliMLhPldoifW65h0eZ57At5E3s
	 O1mJtwFvmCv7fJzdEtJNoMAhD+rHifWsmKDcIDAmy1rXYcE+9N3h+6j0SysmMC3jxSLvU
	 BS3X2Bxm8c/UF4RnoIMv000JHMCd6z+F1Nhz0JqHb+7pOEH5qVsF1mBY1dH5bBNk9Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkDQJ8SE;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CC606A323
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 19:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887CC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkDQJ8SE
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so2608976a91.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795549669; x=1796154469; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
        b=hkDQJ8SE9T5NTx+bSFOZ+oAkTZjhjNqbr5FwlOIkYHU2pfuWXC4hay2mNhTxK23qcb
         E8pT2H1fsqK37LeIiSSxX+PRvqqMIlXOGG1K5wMto2pHYRL7DGTrjN32Kxqb5iHlE1CU
         u8mGCY7DYmYOnknCKDT8FMwDs5wZDo3rUKOjZCq5TlJv7ns4QVJIwOYleRHqUCDxLmbb
         7YnPGhg7aqE+4Hv3MnHRPSoR4oNT9YVwd86QcqSi2X5nJU1eg+L+AM7gmkVbGnnDdTIi
         khfGHwB06pBcZLt4VFZZPlFrOhNv9bh5Db3XcBIMRmkCvI+BTRNN1Py8AOJ39USrGJ+v
         4xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549669; x=1796154469;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUpe/tRxEZ5NPFIdAznJnUvDVmlMVX6s3wfMo2I3P5U=;
        b=xGiM4FBIGD31TrlDkL92sK/7J7NPh6H0Bu1zjFFVIDHFuaWxvVqUxCKBGTD8J1CoK8
         bbFBzMCUh2cdK0U/5S4hIOMHXEuuKxfqbOctNeGLnybMVkI71olAqHIG/1qv5TqarZUr
         uz/2ZJIDXk6JYMabYB6kme/LsEPZHe7EYuIg7P1ekM2iHLvyNK9dTN+7EseNfNgV7Yt3
         LV1/Fnehja7IUMM6k2nxnxZDgOQJlc2uEpbUSpf7+9pNxMia0Jag1JEZjxTzgHqYhEkq
         RegBoGKRhCqK7V+nLbdPsKV9KN5mvuZMQ84U3HJDx7NWfJxSqOuF0u7BwVbwKisR7gwr
         YdkA==
X-Gm-Message-State: APuU4Z+SZqThrGbFHjk07dcAaLClAau/hv2qiSqVxgSgqZoxxBhub8Pp
	QPc0vz3Mo0apqLc2m3IUxD4RU+8KawivyT/G4RBfWJ6aGc2X4ffIRrB3gXhHzK3aEA==
X-Gm-Gg: AZFdTZel4lhB7OGuNsRxv8sONBmGPksatqbm4hxevq/OtdSBzCAf9ueZDmK2u5M9OU8
	02kbSBr2S/tHHd0X3hYHtQWTlqEGz0L8Y1PsxFDwYEHXaiQPTaQNxqNhXeTOdTCd/WU6/vIpTYn
	RrkTlpsVapZEe/pGw4KAzJ6VxsvKPUKFCDpayPB8zcpTuQhQG2cjKRbx93TK7bZFjzXvSi7ofXd
	4gmBNP3fQDdUdNOyCM+AIYg7Plf78WxFeOy+d7MKuW9KOsQEp99KjfQG9PlOLMyDbRHnRuDA/Ld
	H+BOlm7Gh4UNt9pvfhkJkNlBlV93ThKZt5lE/zG7u+svri5gFKGTOC2smUzRDMAYtzDdEJfiFIh
	U7QTLfUVz62BIan4O5RRjqGxiBQdXtsswfJXNmK8UuG+QnrW00oNR/t80h+BhiJB9zaDjz/urr1
	eSUnyDhlQtG6o7Det+nSsuwDObVzJwy5BIZGn9lcFNYrVpDkmNU38WgPd6erK9AF2MkNLVzDgtp
	rcooS59Zx54kgM1iLZsVyLr+7Vef3Goy5WDKypnF3OP3d78V7ImKb7ce7FWYjEgMrOZrZ3jPzZw
	ZxhqZpQabZuCLfCrt3XmESJiUYB4vvqnwJhFvL+i3dRA0ey2NqzM1xnVr4ACfAQp
X-Received: by 2002:a17:90a:e70c:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b41c955b0emr14483470a91.51.1795549668300;
        Tue, 24 Nov 2026 11:47:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe23sm23939545a91.15.2026.11.24.11.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:47:47 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 11:47:47 -0800
Message-Id: <DN3P8HO01T16.1XHR8MD7J5JSJ@google.com>
Cc: <linux-pci@vger.kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, "Rob Herring"
 <robh@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Williamson" <alex@shazbot.org>, "LKML" <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and
 resource assignment
From: "David Matlack" <dmatlack@google.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "David
 Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
 <DN314UP7ZLCR.39N4XNGLWKR05@google.com>
 <42d7af61-bf69-b440-8685-5d9cec4863dd@linux.intel.com>
In-Reply-To: <42d7af61-bf69-b440-8685-5d9cec4863dd@linux.intel.com>

On Tue Nov 24, 2026 at 6:10 AM PST, Ilpo J=C3=A4rvinen wrote:
> I don't immediately see anything preventing from moving it into the host
> bridge struct, I'll look into this.

Thanks!

> Not sure if it really helps much currently because pci_bus_sem is also
> held but that might eventually change (there's the series which
> attempted to split that into a separate lock in each bus, I don't
> remember why that work stalled).

A lock per bus seems hard to get right, since a sizing pass or a BAR
resize can span many buses and you'd have to lock up and down the
hierarchy. Per host bridge avoids that.

> ...I already have another (unsubmitted) series that adds
> pci_rescan_remove_lock around host bridge setups because they too can rac=
e
> with a sysfs /rescan leading to adding devices more than once, etc.

That would have saved me a lot of head scratching. Please Cc me when you
post it. I'm happy to review it and test it with Live Update.

> Now I actually started to wonder why couldn't pci_rescan_remove_lock also
> be per host bridge?? (+ a separate lock to protect root buses list)

I've been thinking the same thing. Both pci_bus_sem and
pci_rescan_remove_lock could move into struct pci_host_bridge, with a
small global lock for the root buses list as you said.

A big benefit of a per-host-bridge pci_rescan_remove_lock is that it
makes it obvious which lock to take during boot-time scans: the lock of
the host bridge being set up, which nothing else can be holding yet. It
would also solve the re-entrancy problem, at least for VMD.
vmd_remove() could always take the VMD domain's own lock, which is a
different lock from the parent domain's, whether or not the caller
holds the parent's.

Eventually, the per-host-bridge pci_bus_sem and res_setup_lock could be
merged into a single rwsem, with sizing and assignment taking it for
write.

Thanks,
David
