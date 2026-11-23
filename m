Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453096;
	b=Po6b9oqB7I+UCkWpihD4Ku2f7eRLVRc0rQl2jhKAJdG3DhBvArnMhAyXuWCNo7Ba8462
	 Pt0cedfCYipq3vO7cryqoRHn7BmbKo+61rlTIK7K/s5/tyrdwNOBjwl1upt+t6LlMIj7V
	 /y/ikWr48yg7CQXFLWuz7DjKktlZp7LzCYxsM/ltIj/VoOh2jkT2vEK4jESxrXITYO9uy
	 X1HPK9+iOUFqZb8pr6Okl1Va/k2Ydz4uVw9Cefne9YU+CAnFZ2uKPjF8hHhJAe6nlzONC
	 JDjuCgQvIBWZ4ePgu1UilSSxP85Vy5/gbW2fhuRvR4EfAo9D8Kn/TRulsjlgyeglTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=k8jKBIfQ5nNOWQOY+LEVg9HBdFbaaXrpreLqMbfabtk=;
	b=IFhCMdLs9RIGy8uAWTDv4rlUe1G13KFRNT8TpXgFxwymDrtafdLGAZ6t4t+o0nAF25VV
	 vBAz8olmqv7DcfR98gWbhd8k9gKD8+nK5mDIL0L0D0eFWaQ3NKnWtu7IHt7GvVasMZ9Pj
	 UUhLf2uPJ2zJJ6peQDKXCEVYfND3seMe4r3rpA2oLMrzxSLmU+fXgu8U17E2uM2lf6ZjK
	 Tgs1O6SubAqUCbTCSV2kWLV4O9iGNpXZdcI7DBHphRonfjKN3Ka9sX2FLtnIczFES7Wyk
	 dGeoZ2LKdjUQNQhPicGK7aKi5hwqgAvMLbnioEzKk5B5u+k8GyaMR5M6sZOj7rXzlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XGaOmIX6;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152B606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 16:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C152B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XGaOmIX6
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b97460a133so2751965b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795453095; x=1796057895; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8jKBIfQ5nNOWQOY+LEVg9HBdFbaaXrpreLqMbfabtk=;
        b=XGaOmIX6sapnbuOR1qSaGlE5t4IfnSGWJp4HhaLRoLFyeMPebugeddMUH4tbJ/1MDM
         ufIG7W71JFr1rF2cdLU8pPhYHbDguMGBWqQOikdBGkz9juKpW/SmH552WXapRw3F5m9R
         UUIBDLaKKcTFHdl7T5JL8OOr7dmTXY1vb8uLWWqp9DR95LtVVFOPYRjVtAK6158447yj
         gVQbFNN7NMZWPHOGsmHbTRZ2WaaA5lGs/yqpUo3NfuYX3vd7x06zwvrxoZpFXhgvfgal
         e1zh755cMHmTR3K/w7UVJMvZtP56zrrcLhmAbEJPynA19k5Zh3V1nvk+Y0CaEWX1O9Fl
         i09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453095; x=1796057895;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8jKBIfQ5nNOWQOY+LEVg9HBdFbaaXrpreLqMbfabtk=;
        b=fr6NziuhkS55XZdppyA6lyYvbHvOKyqr16pi7uTu+7dyco5oquAe/wBpntvrnuwc2b
         Op45V5IG3NeBGoFU0g/vt8ycwGPtD9V8LdysSi1UOy3AKChaPRNzxq4Ce+jgx6dxP9Rn
         t+jZgnUBEMI01oFViZR7wnK9cxN3HlIBylkQKddq9D/4eVqHn3AvH1pL7CvcD804T7ji
         qmJ8uoc71OAduJX3zPEWvRv8FrVY2ZDZpTtNpXis4b0+xGfC7RwYirwBpZ9dyySC2B+l
         QyN9YhoUBqrd+5lzIfjGS9OMV4lCUpt7KUCRJpPkHtRxBHegQybvzMzsXt1hw+/fVAti
         UOqQ==
X-Forwarded-Encrypted: i=1; AL+hErE47s2+mlRSYo6GNRTrexkJEQMZX2G75XCB0cHUDBwejLsgZW4PABGMOAHJDeKaFmeKP7nIOdluY7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A8hobHkxT25Uq3bPATycqRwHr23NCWd0094l3DVk080dNYnjr
	EL9EkEzCNqVM1+rVe8of3Lqb1OJ1QfON7elY/fpHGWe0aaC4LH3XN+OA+pQ/Mib7UMDNBn5Cwwf
	nUx5DRQHiS4Px7S9RjOWf0T84ESWLyAL6xA==
X-Received: from pfbfi7.prod.google.com ([2002:a05:6a00:3987:b0:8a0:91b7:e7b9])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2589:b0:3f9:797f:3869 with SMTP id adf61e73a8af0-4014d359938mr11683499637.47.1795453094794;
 Mon, 23 Nov 2026 08:58:14 -0800 (PST)
Date: Mon, 23 Nov 2026 16:58:13 +0000
In-Reply-To: <20261109215704.1852183-1-rathodpriyank@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com>
 <20261012-fix-aer-mask-override-v1-1-49a0d7aeaea0@google.com>
 <20261027230853.GA519764@bhelgaas> <20261028173038.292999-1-rathodpriyank@google.com>
 <20261109215704.1852183-1-rathodpriyank@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123165814.421924-1-rathodpriyank@google.com>
Subject: Re: [PATCH 1/2] PCI/AER: Make aer_mask_override effective for
 injected errors
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lukas@wunner.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	dave.jiang@intel.com, prarit@redhat.com, ying.huang@linux.alibaba.com, 
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org, 
	danielmaraboo@gmail.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 09, 2026 at 09:57:04PM +0000, Priyank Rathod wrote:
> On Wed, Oct 28, 2026 at 05:30:38PM +0000, Priyank Rathod wrote:
> > Good point, thank you.  Would a shorter commit log like the following
> > look better to you?
> >
> >   aer_mask_override=1 is supposed to allow injecting masked errors, but
> >   aer_inject() corrupts the hardware Mask registers with "&= !" and
> >   restores them before irq_inject_interrupt(), so aer_isr() still drops
> >   the error as masked.  Emulate aer_mask_override in config space reads
> >   and writes instead of modifying the hardware Mask registers, and
> >   document the parameter with MODULE_PARM_DESC().
> >
> > I am happy to send a v2 with this updated commit message, unless you
> > prefer to adjust it directly when applying.
>
> Hi Bjorn,
>
> Gentle ping on this series now that v7.4-rc1 is out (both patches still
> apply cleanly to v7.4-rc1 and pci/next).
>
> Please let me know if the shorter commit description above looks good to
> fold in when applying, or if you would prefer that I post a v2.

Hi Bjorn,

Following up gently on this 2-patch series -- both patches still apply
cleanly on top of the updated pci/aer and pci/next branches.

Please let me know if the shorter commit description above looks good to
fold in when applying, or if you would prefer that I post a v2.

Thanks,
Priyank
