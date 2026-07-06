Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E33D4112
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368327; cv=pass; b=smMjslOWCBlEyqbYfKflf+rpOVv0ZSx7DFkzVi6zErFFuseW1NqgBomuUBLGqqqzLNPhCZiUWjdoUZV5cM9MBK/e8Ycb/RToI8/o8P0/FNePDGyaOrJ2eDPgiFML+owVfqRYpfqRi5Bq/2+G93tp4DjJ5r8o7n0B9j3kYUsVbTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368327; c=relaxed/simple;
	bh=cZzLDtUOUx2+M6TxkHymIb2lPpb+5tNDsr6avCKlGmI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgbqS7hn/Kx8S8I3OAGeV7/7zk5APHBARH7SIKwhJjFJ4um8iZ+VzgR6wFLMTCAv/y8NoIG5rifl70uKXPJAy6x3D5dGCU7zfb8ZxSn/mEnYTKh8WMphIjrQWxtKy2cslgF6LZ4Vo1R+7ijpxIWp8ZciltzpwMltjEL/5F27Lz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giEuSFaE; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giEuSFaE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caf228a910so20560845ad.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 13:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368326; cv=none;
        d=google.com; s=arc-20260327;
        b=Unj+qVC0wZIybf/LLzacmwHaTZ7yPU5PXYri5b8h/elKg+WPiBVZZUHRnZLena1LRM
         IaHGBZx/o0F1jMvSqkSscC28fW1RcuUyJCWUE+cVnue+8XnMpe2OJSchx6SK6gNyXEaq
         TXhACJXilmJa0WrV/HEk+DwvbkYNrb7BRQDmK8beK6bYXXPvjXd7T6ONL3qM8orI5rQE
         lw4nDOBvlpI7G+aDcTW2y4VtPoSlAMpiZSWewGd8+E2/OEXAdvWTzPZXq2izUr//QBOE
         qun/AhTnIMWzzgsL7vsDfrdSNKuyRyzmomWtXHjIsABj+c3tzxH8KvvVNagr+NMoR+Hq
         AoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        fh=QHfpjlVpLw9K40w/9EeLTvXsIowzmEKebRMjGVAClVE=;
        b=d+IJPwLVvzlUzxaxw1YlIv9eUMGi3ObU3sDSJ6u4tWluEu1N3Y7VB2s+D6o3mBtWlO
         ll5vTwsuxlfwhnQY/iRRHqzKU2O+cpZiNLNtLogKXPkhY2vrO9ylIm9LFGFCf67JiBS4
         S1WyWKee09BX8Jv3eMR2KGSK+SnWgDOqh+zbSQiGgAPf0SM3DmoheSy4vTdmuGWw5p9M
         pMFrdncAgYpX5N2osGUdkMG9qLlcSj0fjZe4FcQZ1ykJybWAJEIqY26wFMgxAErZVfiF
         aJDkW2+8souSWqbdDS0Ii8B/VJECYyVZWZLefH6mdbWko2JIcs6CESadAAnb9v+8ANCv
         Wn0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783368326; x=1783973126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        b=giEuSFaES94oPLNtxlzSLGWTrYdHjqulVc0bXKs2L3S5JEmNYfFUpA5YOTtIS6nqUg
         2HbHOdAxImIcjWvWqvwRtG1L5ZXYO9FkdigxKnl8zoyTk+6zJ5AGxyLaYPU1q0JPdnLl
         LG66fEZFEUs/0scj73t3I77WPgDrMLj/0weBGalDk1bMKbFldBvLa/62xBwlR4Ra6MsO
         o1n/jjTZZkgyvrlcpqavJlPTFvvC7O0pwnmKLHFO+mVuIsBZACX6ZqwfuicN6venrej7
         29Oxkc7hgn3mmFEcrp+pSqVcDU+0Gp/dJ+BCqAeRPyBcuqClK+/qKo6zhvlRusSoaAAi
         hN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368326; x=1783973126;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1sJvcjfFSzHCYkLQviAR+AOvGzP6D3rFksnjCW+sao=;
        b=fcKA1+Z8i/tBvBO8PcN+Ezt1sC2jHEJJZu1/0CsxiJqOzl4+vZ6sTF84zOFwW6j2Mh
         U9oS8VxTSF3DIxne9paBJHyH4g0KlrD2sq2pbXiCihVk8u13FJ4zZgzrZM37E1VsYMeA
         /xV3LtYJUSs+OSxX15goAiKf1kaTyCJ7YjiAXdW2NXA0EPpWo5ZauZRJ4cUaE9OKhmG6
         4vEf0LT8aUIsKF1Md6rwut+g+IEmvpyCteAKSpRvxcbq46tLUaoZZeBwKxC6iOeQ2G87
         2G5aig48tEQk8pM8e+1XQD3KjMCH4U3rMwUm/XtT8Z/nZKjdzgGHCguswWrVpALMCMlg
         TwyQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXvh8W4ji6L8jCyESovB/MZkS9xgdhQQVeoJiFWhXdHAJMYQXoaRhHuq6S55K+5gTRYhFQ7xtZosQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoxnXPyQJcXrA6dZLSYtoPTcydhaVqnrW//3tVwnH9WfkMHuh
	DXesR36QF5FKR+cmSanLzt7l5+DoNDCnsIOuIlY/1xa66EU+ynuYexiI3Dk7rbt3wQEmZFYJRR3
	8rVzynZ9HKJb+dDnEzrXGlFtez+v0JuLba3Y7Qdu6
X-Gm-Gg: AfdE7clM/fkS2DGg4QLBNvhgp8CZ6rYcW2oG4sMgg8PbDBUHvABuvrdl7aMAhUlxMBE
	36291rlLVAhbyMzY6HIvMdpdAGsHJKv3l8OlAKWNZoTuLAHOtuD4XG4xSas8jIXQkcCFay+QmSN
	FmWClj5AyjdsrZOfcHCqAf6Y+CCwzpiMKLtQOHdikSMVtNSRnU4tkK8rrbDJkSEQiwcokccGSrY
	U1jHwk2Qruf9xXylQPZ2B/0ybahLPADGFegZ6SXryn3HkHaecgsx200aB70x4LYNqrsK7Pkksfq
	oB0eHdlkV2HYOWMcIEEzsPf9+lMWxbBr13Wtyj3RBUi71aI9U7YfklI5thw=
X-Received: by 2002:a17:902:fc8e:b0:2ca:e0ff:e696 with SMTP id
 d9443c01a7336-2ccbe509767mr23472615ad.9.1783368325085; Mon, 06 Jul 2026
 13:05:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:05:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 13:05:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-31-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-31-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 13:05:24 -0700
X-Gm-Features: AVVi8CfBjO2gULD3GETeRHh9h0KndZBQaojE74hhluZ7n9qbjhbk_11LUC5m6bk
Message-ID: <CAEvNRgFpD3xOAPJPziVy0EvT61a0jjAf2VH0X3ZeHC2z3Om8nA@mail.gmail.com>
Subject: Re: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream setup/teardown
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

>
> [...snip...]
>
>  static int tdx_tsm_link_connect(struct pci_dev *pdev)
>  {
>  	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
> @@ -362,7 +579,15 @@ static int tdx_tsm_link_connect(struct pci_dev *pdev)
>  		return PTR_ERR(tlink_spdm);
>  	}
>
> +	struct tdx_tsm_link *tlink_ide __free(tdx_ide_stream_teardown) =
> +		tdx_ide_stream_setup(tlink);
> +	if (IS_ERR(tlink_ide)) {
> +		pci_err(pdev, "fail to setup ide stream\n");
> +		return PTR_ERR(tlink_ide);
> +	}
> +
>  	retain_and_null_ptr(tlink_spdm);
> +	retain_and_null_ptr(tlink_ide);
>
>  	return 0;
>  }

Would it be possible to define .connect = tdx_tsm_link_connect in the
patch that sets up spdm, and then update tdx_tsm_link_connect in this
patch?

I think it would help in showing how the spdm is associated with
tdx_tsm_link_ops.

Would it also be possible to bring the definition of .probe in
tdx_tsm_link_ops till after this patch too?

> @@ -371,6 +596,7 @@ static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
>  {
>  	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
>
> +	tdx_ide_stream_teardown(tlink);
>  	tdx_spdm_session_teardown(tlink);
>  }
>
> --
> 2.25.1
