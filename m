Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330232;
	b=QzjoyYIsiwTctwTNziDx0QAh4WxvIbZaRW87HcB7SJGvMTycl3Pt9w4D33wuxmUrXpGi
	 9+7NSvjLWbiD4gVL+0aHwwxg5vbvZQ9gOyROPnrCOoNkfsin0wDVUwMsR//m5xAt4dc3c
	 DVUay0+D3QBKIZNIDHkxWsn4e6ckaFM2FaMECyDUQnGo2T/0kc0mtgdF6p4o1j70IgDFF
	 fcfwkP7bpJ8AwRonSxXS1JDlVwCxa6ZeTvQClw+IkYfkJbGWIuZtnsH8oTWryyxWIzfIl
	 VaRCJB+5MwsC7JrYomUqBa2zqH3oNf0wtyimOSgNQuDCR9vuFtCmoaitutVHoZFDrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
	b=boeOf6HSxteW4RPdHd1Topn2OgOAqYha5UZFcTthm1PzCEUD30reZGyujWRQNJI1KEvR
	 fpAbdleCbe5dO5LBYzAD/cSDiNYIzR+XChZI4pYrzODhWYZTfUgFHzlm5+2JSCG4Oh3B0
	 FZAC29CASUN2AVzJv0ooanAGlfFj6GTwyKHojUCbm4XghoQxnGnL9JU28g7EV0wqyU6bn
	 tv4h3m+gl29hFPYG1Cv6lAE4gqafVE41s8FVwfFcdcSmz2wOrRzfJF6XrB+9OU18YlN10
	 JGzzGwheeooa4t0A4Q5cY0earvVQcBHD4KBm2W1AtrxFkt6CbCSjfq6L4X+/iNP+6PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D2606A331
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 911D2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1701161a91.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330231; x=1794935031; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=CqqEuFk0AQlgr0+Pai0aviiooV27t9niWrHV+H8eRhc+6PHDFeXh1X96vJxa/Dt36f
         f5Yiz3snbFS8BnY1j43shKrs+nTnOuO5TOpWAK7YB+Leh5xsUkN2q5DbPCq8EWLyDMiy
         SzPOWc1tlmmFvklAq6qlbkiOasGwfDLouqOFbi0kweOwsAx2q/xRkmpeKCHL1pjwIiGj
         wwWVGLFDXcV06SGp6Uhov/nBULclJ3h1Qlve99omyE4gY7ugTdgLPim71rZ86HGq12iZ
         6lYJrUjctnrF2QxlZ+pOeh5J+gK8+JpQT7MfqqujhOFhX/ZmgaHszxt7/F3aM+6Ikrlq
         SbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330231; x=1794935031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=AJ85TAqZSwBwp96VdnuZ1D54jmHalN0nuC62j73PmPoz6Ya+AFyLS4gqlTvX0PEYC1
         JXlqXoVQzqgV1ebefbDgNUJUHUpp3w6kn+uZ8FiBxVzstKsscG6rBM172P1aNARPf3T6
         cP18vLaQsQB0eDCbgrBU4EhW93F6HG6M2q9WM2jbRPS0ZUoysNvv4W2AwwqVmJ+C4qRH
         yiJNxgtT1TAZfBjLJ7HqBaY1MijKiO8sxWOCiSmyl1S1mEsFzvwMFHPJPcHQOuNKPSY9
         LcKGvnmf3slDs3TIyIkw06z7CaseeNC2+tX6D8HEdjEPw/9gVjcJhKxZ7Y0avpagfxi6
         4Auw==
X-Forwarded-Encrypted: i=1; AL+hErFFMaHyU6g0Cns0ryKplcUovRyw8H1ZbHg5dWgpMWWKmvFyhvdW0p6XzeGYUNfi//4BqMNQxQ5A9Zw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QSq+W0DhBJSRFzhAkW9cHAooyxA9YhA7vXET8v3hq6xsiUJ+g
	PMFNyTAmcSYIXU1xfAQ9uTDY57DtOqPYaY3VFXuB8ExSYLZ/Pw2QLsv+Sjb2AREoOQ==
X-Gm-Gg: AYBFou1/hbzCqgSCi9qjt9MootGZ57OwiS8JLzPgRuXClPwhX3gb1xqCDO1SM5ttSB5
	5tg/H6Gye1w34lLrn4nBO3QmaFX80J5VS/fgzZlIknAAPdisX2p8snHJaJpJZoVodoxx25ba+KT
	5wijdm6drw4sOeN2pm1PLmrxLtKXduS5eq3AZjXrfaUzoZ+1PkB91UhsWK/rmpsRz9trqNvJctv
	SYX1swG631oaH6OfAUHpxYskKLUH740iCUqAAbNRSKatVKos0I8bPm+cAgrOYamuf5rL0tKbwMt
	xs0Q6dgRGVSp8RMuD19rLwEN2eizG6WY2JNP0r8NgdC1i+Ju9l81bCevEHYNfYIC97xBYalwfUI
	HBwB8drbT+BHhdpD7svB80CyuX1bd9KOJhKsuvz9JJVn1Qa7RKSrecZHT9SoqWfiUDEZfJECERI
	e+TkClLGJVumQqfbSlzF5Qhmyck916Y2baOawKHyPHGNJLStOBiB3XzFppyiy3eO/iIcILAVbwl
	L85HUcuut0mE0PYocekaAtTDUY+M1jY2H1DzWZqyfrQyRy90dXI3upxGtSH4mq4YtioN/nBST+C
	YZHl4ndRLCL7abPyUgpQSAqVGeja84k8eVQHxXTYnveICwkgvL9NZSmYuJdfwLVm
X-Received: by 2002:a17:90b:524d:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b166cc14bamr3213232a91.15.1794330230055;
        Tue, 10 Nov 2026 09:03:50 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm514293a91.14.2026.11.10.09.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:03:48 -0800 (PST)
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
Date: Tue, 10 Nov 2026 17:03:48 +0000
Message-Id: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,

Since the entry size now comes from the block headers, incoming block
sets should not take an entry size at all. I pointed this out on the
PCI patch (16/19) as well. As is, every incoming path still calls
kho_block_set_init() with this kernel's (outgoing) entry size, which
kho_block_set_restore() then silently overwrites. That makes the
callers (e.g. pci_flb_retrieve() and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size. kho_block_set_restore() should initialize the block set itself
from the incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

Please also add an accessor for the entry size, e.g.
kho_block_set_entry_size(). Users of the block set need it to check that
incoming entries are large enough for the fields they read, and that
the fields of a feature are within the entry.

[...]

> + * Each block header also records the size of its entries. A newer kerne=
l may
> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.

KHO blocks can't guarantee the last part. The iterator returns a void *
that the caller casts to its own struct, so it is up to the caller to
not read fields beyond the entry size. Please document that callers must
check the entry size before accessing fields that may not be present.

