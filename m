Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC44AF671
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442153; cv=pass; b=dJgrqYcbmTcu+bD7HaVkJGQAXX+UJWLoTsYoVDlNma99cCl8Fttt8s3mKEfh0NIqb0QzG9X+vUkOlF6LBsm2ursd8heq+h3mkFIzfIw/AwYL0Fb7x60CwXjqLPDs4A9ceECmPTw41QIX2T0U+qIOQ2nKefJON22LMjwsDbb4fpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442153; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY8GDPWyrajQ2PsCwws1ONwjGb2rud8e9RvnYeLSwOlTp2FJ7OpgsHckcHaCaTffl+EpUC4aDkrijWb07vE8nEiwxAXFrYqnYOq111dQMreaDMmT3UMnWKob5THebKjLLF0Qlr3w++Ng/+5VccWdk6XH8mLJRWZ44Y+sx6+YLpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e252fbb7bso341551b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 06:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=Oabr+LZGtAzinbS4oObZxr+vgQq29T3O86RZHL0zwVSsK96lpSQz9REiBrxzQBUFUr
         svQYIswCP3I2kMlPsNv9FNRjpbl30lraOdNEy8LUjxdcNLsEzn1b4biqNSAynJaFdLoo
         mWkZLpNyj8BMB+LefMJ9BrzITXSYDDeW9NlduCOvAWLMXQuDdHZ7Tz5lPjkvG+ZP+CZr
         RFflVYY4TQ8uewuOp0eUJ2NdOfsLmn5rTVlPw2drg77JJJCSFmcNDfpsGaNgSmqsycko
         gtBCIaqP1+OizlX1SNBE+hR7R2qY/RRvutTxD2+R0Y0v+UqqiVyBp33Wh05p8Q2VcyqB
         13Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=94cRHQlGLTAG5n4XpYGMwq9RZXfHm+fStHLVZXEUhNI=;
        b=i41ZN+viB3nJ/jFS/564jf6SVQsyQOfQyNDKWJJBzm6961wE7OHjKI16b8Pqy9XAGh
         P0tUvxdqZuumRVEAnKCetOSid1rfXviXPI9DSCa2sPuzvVDIisKsjOitfzq51ON0olh6
         u19ouf2+En2hQGipBW4DkXnKJZz/M1KaCMdtiX2P/FGPCJDRWF2BSpKzfaxQ6PfrXj7p
         h+Sg2JNvIWgBGOqcv8WJHsYK555CiJ7ju6qnKB9tX2j6A8ybyruw62D/oSK6+BZ8nxZF
         49TUNLANdm8Ftyt4ZEkZPZ5wWdvK9SvpCLL/hN6HGSgzuorcKOu3zQ6HQtxZN+W+YCaa
         fpAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=OYZ6+yZUTWQVnJtJDqGvMAMs+kzgtbyp0wnQUGElWRPjNO00ITxQjrsrwrlGpgI4iC
         pW1mix2KU/3Y/fib5M+TGgTWOvwfTrgCY2tCzyCmENlT1mgcBvvUHaXxXBGmbu9clmHd
         tJSdcSYQQDptNPMm4t+sYC/6miinPOYf3gTfoZcDFB9jCiuvUyK/yhMZSKnk144f2VIM
         7z/yjOMNIFngqu90XaCq8uQabjxyMyRkwqdDv4stNU1NpZVhwntIHRct64vSHz8gFxmM
         wAK5YTgzzDO8i0yqK1flL/SWyy0YxlikTeZ24RZH7VabgYdF0A3qinp1a39sT9NhJlY5
         6lPQ==
X-Forwarded-Encrypted: i=1; AKwUvBySLVjWLB/54fqDoclTn8Cti1utOqPnDy0fTvzJChMGFmRh9EoRJ7Dypez5cuammNuIdz1WDngu2HI=@vger.kernel.org
X-Gm-Message-State: AFuF++ml87jPr01ZKQ6n/YxRDmdFLD9yOElbtynuz3e8g7wdyZhv3QkR
	lz1s1OChharUiMahlP9GGC8kgQxzlIBUr4QrML+xB2D/DlXk0D4nK4RqGehkMPPrVXNl/trTNwg
	z69+QuxxUObGe9Mwkkh/Gw6PhYbVQsDY=
X-Gm-Gg: AYBFou1x4qFmYxlDCLGNxh964z6TfrcfGHLPoKQ5Os0fy2jOjHJINypjL1rFgR5b972
	hkMQGU3x+7BQg40CAPCLh6udJ8BA1x2G24oNa7wn5YUJaj8ZyFxmPJ+kNrgWWHDH5s+Qu2AJeWL
	nletD51HGtyxvU8wo2Qyp3Au/lAilue/g2Sh0KSFflNI/tmzxdfD3oxbjQe4FzQg7A5WzLigy2D
	mSHgF/UvPRqYM4MhCV/XvMVBoDHtr7xOE6XyZgjCF0vd3QMpo1o32IzVcwc/52HbuOdvRK8F1N/
	bS4ZD3u242RtGPcGOy+nOuk+w9ctZD8OCsHXtbC6shZtm1yv87yY+7DVgZm15GNQIEMiJn0RAmg
	4q3VXxZc3jJ+Vxwdhmr3/B3+7Ps3uAU0eGYr2QN4IkwZs+9YUEO7jeZLJl9V0
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
