Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083234F497
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509229; cv=pass; b=Az88tmhBhBrjAo+P3eD5/LQBSDDMO5w6rJnVYR3UyCtPr4sf5FfOfXOeY31ve72hGeerSv8AoAi/NiIfGWKzLvePacRi/+jt6vtfvvKn44OathUJGSCsbPTNwdE1jlhtkVwj15DU+cFffbdH7ZtIusko+BNQNkEarj/kMxBborE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509229; c=relaxed/simple;
	bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzM+zgX+RqyZSz5ubCugVr47Zt6j+5HcNNWAM9MxI9UizDftwuBG9vBcWoV/rxKG4pcmU5m1mvshV47GyoknauH6+lgHZkoRhBDGFGWrCQ1JaK/MEqz8NdyruOLadAPm/Mxaf+G4Mwz2rciC4GwJJAa829Mpo7fj4mp8px6SLbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaMcgFKE; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaMcgFKE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b0684f98eso378548a12.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 00:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774509226; cv=none;
        d=google.com; s=arc-20240605;
        b=Mt+y8eBlNNu4vfK8+smvIu97Kcxby7mqPgPNioYv5hLTxSdr12inQbiIqbsnBIB5UO
         V2NetbE8D4gcvOd4cXH8VzYnFPLZ+RCFfZ/jmzn6m5a9WXeAprxkx4YBUAfIrIqWiQ3o
         JFsi4W8q5br/GGOse6TZoX+6OGgHISw63nFluBjOLrwh6ZTh9EwO3GsiXesoTZuePXa8
         prZM6JcbBLYyI9+tpDpWY2SoJL6o6ADUt1pv936M59sEQv18kZK3Vzrs4/1mfkZMHAG3
         kilg/ukgRXqCX7OvK37RVyNOFgG1EhYitB9/E6obhtoVkRSq6nullLCEAXAo9Okd/oEm
         VwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        fh=19nbFJgcJwFOFBRmhZNzgFx1BjEq8NdmPRF7rPQV2AA=;
        b=LRb0pelsiTLFzizqLuVyLg4OnGT7kmG8ZxP0TuWZX5bfZVzCuYcFzJT38/abA1mlXM
         g7ezBg/JFfPs+gSbbVH/4f69oVZXMEfjpywXMchY8xR3JrV/fVqmj32xbs2rLDuKxiDb
         n3SPjvPf5kCq0pEAuZedb994CXQDz0tEZEiOcV9sTjzFv33xP00A+tNfoyiy/W6Mqrtb
         z23JpIwHeIWIfKumw/6zOcy96c4DhNhEvQbdfE0kM+qTOHF6ygxSeTGGU9X6WnFzQVTp
         pRCBYWc4BbpfbjfWRLL60EiVYibqNQpVC/EfqbZXGa2ADFBUO3l72AJj2tTJR8gSTcuS
         3Y1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509226; x=1775114026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        b=DaMcgFKEQzwzVn+3dRyxTXKcyFW7z30x2q4rTZ7DbPyAugOhW/hNCJfC/X/RC4m+qR
         qT7JYCFLdmrPHAcqaEClNtfz4zCNCafSsTx7kVaqU8NJGnFq51SmFzJqRIKAdoBPZNWd
         gUNVkACr8KWXewOfFgVaGLKDWNh5JQhSLFtuhPhPXENFa7oc8p9XvYRKJTjV5hQwVxwh
         jqPWpzXPvbsluzNjwluQ3YaalOyxWZFlkU2ii3hH9T8M6s3ihDQ465b+v8eQgYws2UnT
         yonjt8cQvnlecQd3ZaSxO71XqUaLs21lT2gIjNPWxXCf41KB8ID1w2oi53fI9GyatG8R
         ZQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509226; x=1775114026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        b=E7cKCVs15Lo5VPBIGvlyje6xqsaHCM0ygxAzDrS/6UF9kiKCq3YvT8qgBCRj+Z2Zcd
         gfbEBXV/62xm1MwALr9hrEW4tBqChT0QI9b+lfG/TBi/iG5CIaHm7187Qfc44qTQd6cT
         kNq9HDNpoE+QmEdh9ArzMf3o7cTZ0zmx6+m3iMLt9agw5NFitpEUnD4KoCM2ARAJhgW+
         R7gzQW3GpLnD8WsqmoQV6fjmIuE3E5yq/eGqDcAErfeXFSBA39KyIZ2TduePBTdYFBtX
         9PA4w7hmHU5RxV9HOOvc6KhZs1/X8R5PosC0NsY3wVm1WSsoqObuVsnxgo2+lqncj/ql
         BozA==
X-Forwarded-Encrypted: i=1; AJvYcCWThb+GshX1lLpKJc28HV8NRdRp8CeqBPvuG5UnGiohomrg65s3iY9uvMowJANMC0vMT3CltLKBvEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgwKp78AOkuSwInn6r7/Je0+qOymv2v7SRRn072Uyxb/15ODW
	716cDOKxVDl/BtcTKjmFmXMrsKWpDUFmlasND9T3QCcyoH+eI1QgAMCFvanalaCzKVtymBT5l7z
	hf4weyg4ni66nv6BEGF3Xo8reB0hQX8g=
X-Gm-Gg: ATEYQzz1kiETR+BZ+wV7jREx6mEZGLmeLdUMyAPJCjuWeQlw+5n0rSY9z+djwHHraM9
	wFeV+gV+Bqc814HtV5s7rbu9WQUALRifjHTlEq8+zoqzIasn47Kk4XvNuqNpyyRcfovEmbMqF4i
	nquJB8tPHCJZK8YRgcyoNHD1pBG0AM+dB4aZoQ8LFvcmZCVDQwFMUuLz1ZqDSwfRxLKjG4zT3AZ
	CerEnqwIvk3wNgYL9G6YkmJF4Ica9ZYvTn0mVUnEpdDt2wfTN6yvZwONpiFLj1vcGnhu14wYrur
	dRddIA==
X-Received: by 2002:a05:6402:35c7:b0:663:56c4:2dc9 with SMTP id
 4fb4d7f45d1cf-66a826a164amr4266656a12.16.1774509225926; Thu, 26 Mar 2026
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com> <1774403912-210670-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774403912-210670-4-git-send-email-shawn.lin@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Mar 2026 12:43:29 +0530
X-Gm-Features: AQROBzDOhjtwDHUqjyR7aLHKrElwwWK5j8GxED5sK_-NhNXgE0WUA3wwNc4lR-Q
Message-ID: <CANAwSgSwKt04OYX4ckkMu+iRm2D8BFp9FpjRWUh=5ad77dErqw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

On Wed, 25 Mar 2026 at 07:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
> LTSSM history. Any LTSSM change will be recorded. It's useful
> for debug purpose, for example link failure, etc.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
