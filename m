Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2536C9FA
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454758; cv=pass; b=Ssg0EiSjQRaYJtbP7npRgDdYgw4ocDnURon09e/iLUx+HRcWclgfP0T5B5CCcS0cd4GtLubodQ3HIqHaiM16QWRRMHiduIjC+NuzdQyci+SqRRFoswv5SaxBxFnXDQPy3gKPQZkQKWyIuaMjBFWSN8l91C6PKeL4KX9yPU45f0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454758; c=relaxed/simple;
	bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWd+XDCSd2MP+WTvR0hWVcFQtNmsmWpG6Hf43wxoRBgx2cbPBbibltxEd5XYMZJPHlJe2rqHCb22ty6PxZotq6OjNUH8lQjfcGdQfWPUqqcAldaMWkZQvob6AYDcxLgc7s3zXxGIHnv13wRMyectLRDd5QJ2Z/oFXwMuz+glx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtoUIMmv; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtoUIMmv"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bda3b4318dso338067eec.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 04:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454757; cv=none;
        d=google.com; s=arc-20240605;
        b=Md8+uVK0daQMR7PoOUKmHEmbrvBovfgR01TwFRMt3YCtjwOK7p4rYvJF8Q3aeUSj0f
         xTi6WijRYS4ale4HkKxvBtS611YG4xAb8yLalIGFTfidaxLr00stdzXfeI95uMvAO+zp
         WGGpmc4VtoxuSp5W30rtq3cvpFW+Bt34TTInk+woVh2i2TBfxJB4FwWTYnKPgu9WCn3F
         /44HlyxhI4gt5PqaW099zd8cjuTU4ZKi72RvZc7bxr7UzqKmfrXCHOhvtrURWbhj1Ozk
         5Ez8kl9aaLq3RYnZ/59750Anbyc5HuM0LaG+K0tv+nQXKzkrhZjsNxJVK5cPyjEIC/uA
         LZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        fh=hy0EIbdJLnWG127p+sV+9k1sGhA0V6aBJ0k7dJvDjH8=;
        b=ZjhajZQK0m6RjJ37cuPFVX1vfErJBlIogoab9YdgULRmNRgXFcmuJ7Hk5ubimd01H1
         lMbuMITRcNRYc0bDsTADZ1esQx/2J7FsOF2eR+YwVL8rbOTY/E/WR92xYH88DN2A9tIs
         BdbQkhDrIFc4Tw1p80wgI4dK0ctJNOFCrtqmIV3en2nXdJDwkliWxr/DAKwGEcC05euE
         E8wqOfYYMQUsgXoM7v+OAw+Q514ISVLkxkbE+0N8JYhudMwFVofAMWePMPWhdaw8f8RO
         9udULWEQ3Nwjxorm4+xm3j1CFGGSBMriXl5uzF5UFoye0sbWi43RRHNuvieHwnF2R2Rt
         rkjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454757; x=1773059557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=KtoUIMmvcT9a1/mJwfhsK4ojPgzcyjaxTFsEcYoZHNxa9cIO7JLI8+2vzY7sr6IXWs
         INDCyzwkjX7MYDdtmfTXbb5lNbJJyUd8EAH+GUZn1TLJlwfVj3XfqpdzLvewFUhWegbJ
         houyxh19vsOHE3ucUTuT46UASQcLmznDmqjYrOFDtNM4GdWzVpPFJaAnG+iJTZcL5I6+
         43i7B8ennRgMwdU1GhdIbMex7AT/IqbwGF5F6KAHYkjL+3inuUfXyYPZ2WU77m7wvmrV
         tX0DqNdR/hSNUqoZYQjeE3p3Usu63AK42R4NCObpWHhSI0UjKEhpWhjgROxcziVYmWdo
         5M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454757; x=1773059557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQz0rPb0FHUXbzgHRy665O9Jasbnueaxd3e7FIEzeyU=;
        b=PSwuC12on5aeODeHaMoyXIBSCGNOpDq7XxY1ageDXknDt0RZZxj5gHKtRtSxCMFMJF
         0pxRORMglzTHqedGzUolxGruUV1mbdRgHCXgJS26fDGS8fAMYJRNI3j4HGt8t3JBBkgv
         WqzPremB3f3GM6gFRrVFJLxBHdjiCoYfrWpfb9+BkLHkkhuz6vjOVpP6gZzrgvX2mDbt
         nPT6RcroTP4D4zdsp27IVqYwRG83LrT6NC/8QYkmLdexbIy5Myy2Zp/lquhBYlaBLT2L
         uo1p/VfhSi7RCII/Qv8JpiTF4rID8gs+rAQ+N9XQvng6L8bIxUkh5Bonuo+xzbfhLl7P
         f7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CFxKguktUBMFMYovUoPgETgru05nRcSh0fH4RVFFyce+Pa114utZyNCgNPYYd1/gkHlGuofvNg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKR2b8FoWwT0xRptzh3y6Ljjvm8c0teU8hcqhlsIn++EmRy22
	quSjTl2wL8VIDPscYtJxXi87lJ9qyJ5LbDPSjMURBh3Ew9KuIkoC2EzBy1/nWaR+/OrVNPzmttX
	0vtbwOZYxf7xvTX6KLXJwjtIbIn+HIOw=
X-Gm-Gg: ATEYQzyf7KUhUT/mMeVsogrLUUKp2Q4GLgWiEPODA1VgA9wVlfIwv4E96rnFUL6sJDL
	ARAI1Z5YlA7Dd+uHry+V0YMCWc+UOfUE6KGRCu2wR44bjpDirvCkmG2q51aZyc/55ZI7oWZneUs
	dV08w96rMNLQkMfqvS/gDNNDBX5iqsNV6y1usK44TjoM0BFXiJnQIuwUuvERjNtXIaLthIYa2w2
	XFcKZd2oj5tJSUuUMuUhIBWgIrTiAF5rE6Ussc4edm5cfnFg4/bh63k+WwWFn8rohELzwIIHx0w
	BTWAH8MSNLUbBKaWsUrbrjd7oe+S99fLFF5F2294OGVFegQc2QD4CpGxXmLzJP4T1286FHGlzK8
	a/XBMTS1lnmD+fBNlyK+eFD/w5Wk/
X-Received: by 2002:a05:7301:128f:b0:2be:1946:8576 with SMTP id
 5a478bee46e88-2be19468a7cmr221836eec.4.1772454756603; Mon, 02 Mar 2026
 04:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org> <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
 <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net> <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
 <p7rsBPaYxHKSMFCYVUFY5hdI1H6jxHK0s7lxLQkqH4rylM6yS03Yt52SCjiTO5qBVUmc41ZHZ7XZ0_3w_U-O0g==@protonmail.internalid>
 <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net> <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Mar 2026 13:32:24 +0100
X-Gm-Features: AaiRm52T7cw5MIQan-WghpnUecgDLtb8HLJUgWIjNNPX7ugGbu9wZy-93BfirNw
Message-ID: <CANiq72k_c06P4_JVDCNmwu8SwCUP3UjofLCAsovBVzQi=fb6CA@mail.gmail.com>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> I was thinking something similar, in clippy or checkpatch.pl. If we
> should always have this attribute for small functions, we need to have a
> check.

No, as Gary said, we do not always want to have it.

So something trivial in `checkpatch.pl` or something like the existing
Clippy lint would have quite bad false positives (and even false
negatives, in the case of `checkpatch.pl`, depending on what logic you
are thinking about).

We would need cross-TU heuristics for this, because at the end of the
day what you are trying to say is "this function will end up being
trivial even if it may look like it doesn't before inlining
everything".

Cheers,
Miguel
