Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330446;
	b=h1CkiUYYmZkJnNYAxS4GLv+c7vH3m8ChJiwD8hIPa//w+U6mgEyyPY/+b3ffTkmYg6PM
	 /2saWt/L7b9BW/VTgtPCFSJtWg25BnFuvmztfxToWEBVc4fuvKf2RA5ECbysfYwjLzAxX
	 NYH7d+d60pOsT3YNCTB4EAC+KnQjyi/B4CFu16ZhbFpw0fiI7kTVcFs8wzakeY9GQjlGn
	 GOHbKcozigieVnzR5/zUekl33M5/cbgfbnhu3We/Urm0FLzWxlQRfsLwHgnbTwhkcYWc9
	 /22CJHcLb3ScB9ma+ZoympHzq1A0NjpDtB6qyF7+h6rxEQhEY387UDiWITN9LRHVYbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
	b=ciNWR4HFuz3BblE8/H/AcMApCSjbwJKqjAEP+6PTKdT0n6B45Q7wioUY4p9qNqIr0A4I
	 5EUvBFbqDRJbXekL0rx0jQ9bqD79PvPB5izMhIH/2Dh0U14z1TtPMiU4avvfMqUwHnZW4
	 lpeVuYJ4PT51EMDMe5esuz96p0c31E/w2+6D4RxrE+/Jz+MSPCQBt2UrPxoPb72Di3OZx
	 sse3eRTbZRNyU2UbobDdDcQMmYZ8GlPd+0qNZfIXBck00znVi0Ti1NYRHxN5k8HSE2DWD
	 PlrgsqlMqIkaOnJ0fzXGJOAoYsgF1Br5skgwUCLtXoP4k5e3EDbcOGO3sxoTWNh+05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCD606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 17:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BCD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1501598a91.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330445; x=1794935245; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=UVKcRwO3ejBDMk8klGa0pwyOX8V3E2o9Z5FDLbNmULmLkseoQWo3Lqy0OuNTv0i92Q
         ZjjYVo9KXE2zdYV53r0tp3tj121+8xjU74d8CsPd7T/ezb0GS32Oj0pnMKjoXKzmgYz1
         O+RYemVJ0UhckajWqJT6SbFntkibstlz/QpbrXg/A4Q20wwQ7hX+udbRjaT+kVWhERei
         LVTIfg/qTgjrELa088mLnh8eLDqBIePCWGGCjuCCKFA4k1sI0K7OyO7Ju718M6mBSoNU
         6TYqsOoIMH6yBuYtZwE0TFkjVgzg3JMY1p5vlkSwdwLpdJ4u9Z3VALtaIzkru9F3/ruI
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330445; x=1794935245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=dTUfJeNQpFEg0vc9PtkR3dUHSg18MCGXq4z8iJVYHUX91BbEw7CDqEDMtXUao4GV+/
         ih9lwuCcY6GyC20Bjr35qYkkzXIaw07RthMs3UhfjcQoV+/u6fZ5twB6HEjqub1Lz9PM
         b0lAwbitfGM5/Ad+AO4LKiDwPMnohK2SiuZiuD5ua5ZqfiHBHkJc/uGRTDAEqKA1Y9fJ
         XCt9Fnkr1i/rcAbEhmXSU0GHcGGzRl5CzTVvZ8iRqds1GWzgUpvcc9n42+9hkXEvCFwF
         RmCoDnI5oLL4ZruaAQaR2WpSyDFoy+DNB/cKn9Ri5Ep92I/kT9HNVQuptSX1iPHMhULh
         c0vA==
X-Forwarded-Encrypted: i=1; AL+hErGQDKOwJnhyTc4wt9kDf7OfA2mZGozY3kF9/Q+RC8feL2kauN7bnPVKYuhmJNcpucvDqBddUzQy/eY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xOgXjp/VzT1lffrxYPdV11ekmWHJd7X8B0kGJ9NNCCRmSKc/b
	IYHfewxvikELYgHFwSyG+l3ALHRvY6pwLIr+AHbsMaQ0H98e40JGCmrWAV7jc3mU7w==
X-Gm-Gg: AYBFou2P/6ZqZdM1r02LiCBepu+stI0s8v3qy0zMDBIX/h2lMxJsOe4YIBwsJPGfpdO
	kFl06cyCTgC4yEM2rcpHSPs/LJtokfaryd1OUIjDPTi5dV3pPjj+V/XtY8qZwH7BfveHLiUEirA
	TE2lyzNfnbsTOiXb2FL43ualeuGc6l0xLqlNbkh9IITH+pCbOZbUAgq0GCDzDHfNI/xOHg0ubpd
	LwoJ+WvCHuk42Is6zTJrsMDlGSj/vVYNmBJc6F7txssJ1INfYgvUhQwGO68U0Cjosp29Vb1/GG5
	BguZZKl4RhbUWZepItnVZwXOT44g8XfK0XwjJ1C/QdRrIkcV3UAR3MR640a32k2dzUVVnDCSiAw
	afcpxQOZlhyKzkEZvo83h/rzKlWIoy+atw5AKMe5M0mfvEcXln/eYgjt2dHU+GenSutd/jCluph
	enNvpBYd9/mfP28ZE3Dg35PW0OviHMz5yNs1BSn73JOxy2hetvFtFsRcR9u0JuyNkttRQMseiJI
	Se8/T3CSe9f/5JKQ3V9eCJuYDpAcUhCjCdyaKpwRsKtVoBF17pVMCK7bNmfVxbiPtzlHqTQlU3D
	jrzw6sc/gXnZxneIcJTSg5foJxUcDI0WhknamYxsghAGqmJcj+rIG8xfExWugqbn
X-Received: by 2002:a17:90a:e7c1:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b166cdb54amr3659496a91.46.1794330444574;
        Tue, 10 Nov 2026 09:07:24 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm499973a91.8.2026.11.10.09.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:07:22 -0800 (PST)
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
Date: Tue, 10 Nov 2026 17:07:22 +0000
Message-Id: <DMRP21FATCC0.ARAURXWV85JP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
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
 <20261110050202.529473-9-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.

This adds a feature header to every block in the set, but the layout it
describes is a property of the whole set: all blocks are written by the
same kernel with the same header.

Blocks are only ever added and removed at the tail, so the head block
is stable for the lifetime of the set. I'd put a single set-wide
header in the first block only, e.g. a struct kho_block_set_ser with
its own feature header, and keep the per-block header to next and
count.

entry_size (added in patch 2) is another set-wide property that belongs
there. All blocks in a set have the same entry size, so recording it in
every block is redundant, and restore has to check that the copies
agree.

[...]

>  		entry_size =3D ser->entry_size;
>  		bs->entry_size =3D entry_size;
> -		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>  		bs->count_per_block =3D capacity;

Nothing checks that the blocks agree. Each block's entries start at its
own fhdr->size, and count_per_block ends up being whatever the last
block implies. With a single set-wide header this can't happen.
