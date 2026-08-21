Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FE493633
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335567; cv=pass; b=nV9Rf7ocKUT19VCRzxyUvz0L05Zl3KUhIc7wPOnMlPJD7rxpKqRiuF1kwBmE9xSt9PY4hwJXBBZR4atY493AkX7S7PvJ3xNGeXvOrSgLjjv4TtEqgvqudjzPzDoFOVw2BLUhXqtMkbKjbO8Da1QJjvkeUmx4tUIY1SGE7H0BDxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335567; c=relaxed/simple;
	bh=1LthjORSPcmpyo5UW7oXGx/EBc/qFcqg4eoh5yX5pMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8YSLUVndieUgOhhXrdePs0c8l33scESaA51ZAqHqSuOgaG8PWwae33fPJD8WlHru76P2x1/wk1mmxNdry3HAPtGZqcs7tt6F8zOA8k1sHlTwoSwd66TkdLYOWcqvxOraq0rWY3l6fLnl2xa6nswQi8tnqI0AOsVeqNiGsp2zEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOqCdRox; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOqCdRox"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso986a12.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 11:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787335564; cv=none;
        d=google.com; s=arc-20260327;
        b=ojsGl+SJhuwiduj1YIptQ+eiUJ9gEx9F5f1jH93pohWHJpbjFkSKp6cITi4NydWpkl
         p/Sq8MABCk8v2ZK+ws9cqo7zVku5PvXQs198R9SV3IjrDPpuPlrh/G2vtnHBrl95IxTi
         in0JBxKti4ObN5gdYIsus/Y4QC6ELMQDEjUWIa/1WEXKOQvTvF9wXU2yS4Fxdg++6Bzc
         s1hxHx8Z7AkEWBHwzE2F/uig+z773CC5NAn+9g2zUFFLyzdkRJjYAXpQtj8tqPZt2iUt
         GTf9lUt6zzXMXQpqxXcMODuJXOHFVZaJ+3KHOvCo7cYGlhq7LT/FO3QLbPNVwbKIYWqy
         8K4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1LthjORSPcmpyo5UW7oXGx/EBc/qFcqg4eoh5yX5pMc=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=olqtJ3Hi9ZD7J8mlgCczSGBV9qtzFQ1bnTKcNHwd/3IenwHXTCwx2Q9UdfYiaqnEAq
         1jBq+SD8rMD2kALcWRNJwSheP1+qM0+otNHqMNmuxQv+4lo+ardSEoF33ZR+kTAiKacb
         /Qv0NwCg3G0FiZotLzdluBL/OXvwnvpXuUkj8a5i68Id4atn0ZqM8zP82X7J9hBbGFmx
         e6ngCGBlc1T9PNkMOzM2eSwGZK2IUlrCps/6CHetygxyzzUkQ6Kk8IPy5t8R14pKatXN
         pBJh/TqMhHevYqUyKT7h0b9pe9IvPKe+nJqZYymadjRxJ4vxgVzJQeqg1mfVvaWRJsDT
         pyNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787335564; x=1787940364; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LthjORSPcmpyo5UW7oXGx/EBc/qFcqg4eoh5yX5pMc=;
        b=IOqCdRoxC8RXPbjMZ6qluU0wJQf6MPzBnbp3tG5IraKKql409d6+0JyTZvRxUzvZiT
         6tTqc/jjc/sffPnm2mIgI6WfDpVxmSenuR9OyFvVrjGU8t5KxSp5bloUxiPDRNwMHuBA
         EQ2SZoV1Jng4d+qTkR8SQmvhv0UaKQWoq2eqhrbwmk4p50iH6FoeDn1j6LsW6Y3ifeXx
         uVZ/I1Nfq+16J7oj5djSGxx8RypErH5P4SPOgyYi2njz7r8VFmjPMDDiLxoqEO9AOWdB
         HV2kb7JcsWvYe1T/KktLsk6kT8+LMRUMWeMYAc62N0f2kmiB/JdE/c6bTTs9UBTy9aiX
         d+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787335564; x=1787940364;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1LthjORSPcmpyo5UW7oXGx/EBc/qFcqg4eoh5yX5pMc=;
        b=PbNyDcBHEzI3fiU4nlRtPNnmaf1z2QpuQXDluMbU77WuZyjBRXO6q0IGx6VdivDhdX
         Fm/mfm+GAw6LrXBK9E7rx23qs0hhd79Mb9nTvkK324kcEq1QrYo3s9pI2Mabcqj8b1Ei
         f4vqygASNxOqxwxBJCMnyp2sv56PMZmkWpYenjIYZsvT5xqc8RVhXZMfkZ0851eCQQLX
         LMMhzc9bVEjH/2nZvh9zjKTIdVsdmm7PMRIP/osfJzvync+flndKyHR7aeTAX5rCAWQM
         wqmG9LDnHCBVsDt5AKUCpkpyUpJoJ150aeceY6E1o+s9fMLSItudthJI2TAm47aQDdKX
         my2Q==
X-Gm-Message-State: AFuF++lrgFY95mhsF/fLPWvkNiIThmnXA4/05p1tKk3yNK/4WOW+snLu
	fG+lpx2YyTYzh30Q8HTIBHETdrakEhHyHjAI4kDXBpqUQP2p6pdF6jk0xm9GXrJzBLS7GAcOIVr
	t4DZ22nI7mlg0blOKFPLPixHzbAZvo/kpfMg9M/qHRDGt55KiU2HWm2ef7Mc=
X-Gm-Gg: AR+sD11YO4d6SwtWJGsb1i/VJCAkBnK9tRtTbrpg6f0Lpks1TP/LgimwHqCfTyzpDrF
	blzZxeR4GB4P9Ww6M3qms5fR2tI8Fec/GSb2DlZ/CE5UdTClWpbRzvGwcleQJQkoHO3u2CIlvmx
	VJCvZa2KpWpUJ6arEudd9AX9h0LCdR8yBsins8nKVWIHgtod6SFSazdozTHxOdGe36YB80axLSa
	rjc/FBNHWxXza0TQMrAifU+lx2Wso/GOO3ez2mm8Vu94q3sjuDt5n76NheX9T3x/Wix7WRRBu8u
	TYVRzSfFR+OflqCivaX8CKNIWZAyXUPpGxLxMgLB5ReEuioae3ENfgcti8vkxMxKC6xoHiPNuwz
	nOOYyP16kop+kDhhQD8okDcfl25VDDhGb
X-Received: by 2002:aa7:d58f:0:b0:69f:d9cd:ec41 with SMTP id
 4fb4d7f45d1cf-6a5829285c4mr2112a12.6.1787335563218; Fri, 21 Aug 2026 11:06:03
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821134521.2211943-1-aniketmaurya@google.com> <20260821140140.652491F000E9@smtp.kernel.org>
In-Reply-To: <20260821140140.652491F000E9@smtp.kernel.org>
From: "Aniket ." <aniketmaurya@google.com>
Date: Fri, 21 Aug 2026 23:35:51 +0530
X-Gm-Features: AcwNN1Vll-2JGB7PneFsCkdYdlfUsx8ee3WY1745-4slYygAtC_iXP2aaVNBdFs
Message-ID: <CAMmmMt3t5dPVfoZAir-n5mq9MUaa9LshH_29HQGMPmWKtzB5=A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This isn't a bug introduced by this patch, but the ASPM sysfs show and store
> functions fetch the link_state pointer locklessly and do not check for NULL
> before dereferencing it.

This is a different issue and can be fixed separately.
