Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877D3CE096
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950465; cv=pass; b=XasnzmHQl356pzbdLrq4U0P+mStJCzwBwGtzv44w6iCTXmkVlxRFMgtoTrfBC7qP/Ehr6svqvC5qXspSUuxh4LOhIntvU31AkxPdKIrNwZBriq4VAoYLforgV4EeD/mCc1VXE0o2y7Trv+wHIZo0rfasVW5UjIlP/h4LKlj67p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950465; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUIxs0ifErgOorFbPL6NJWwlqKvHG/5hTjVNLVl2XPtGs9tfKtoqJNUIr9/o/8vGkB0+BcNWKhvHaSExEExzwBbbYW1u/HoDI4DEGCCQjBwG9jN+DYLKm4W7vT3lsjcM1ZI2A3Gjht7UGoc8t7ekCSdNsuKAUcGDuZD3sdIPUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf420670bbso2244495ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2026 10:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=P/R2FkvSsp6GQeB4c2AwVdXKVwTRscYfc8TlfQUPcpLJj9Iz9gRh6cfwspV7OFEkm3
         cO0GmsuWI85YSiB1WttozRtD3frn6gPevOYEI33S47Yt8I8KFySJNw5V2eBXbb6xN3e4
         rY1WwbWRqc1KvehnqaMX5eZOmNz37fIuoiZOiq4LHe/+wE+g1lWD7rarQYCS2hP3TnVc
         nvy61HdQ+jyQHU01AFMwSpVUr1yvatAXR36zRgrfHae+BqLuaK7mK0+dhLuRxq7TV6So
         8DDC8QlHH603FDTGNfXfhMkBuR1GV7EaY7JflfsTUGZlnPnEjfJi3bb01oo9xxI4phe7
         UQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=Dg5AW7qQXdyS1FYsvdikMLEVB7rxjVjaA1bLqldthFU=;
        b=qrXtUdYSq3CH5GRfikKerRlnI/uMY81GsJYhhpAPRorgMyfYCwhscgzoK6cv1dBF2r
         AGy1+cnDE+CkH6Ft3XfpUeQPXRQAh86T/jqty3K2NUT7pDM/Fyj55CAU1/gKyraso31y
         fE8DMOv/F+xm+tPIAJEy++LuEjXSXVolhOy7nGqfq0zopcpNbVTr5yxaWo9U2CYnlCTy
         cOZpSrJMnK5AM9D8tQGyvYHdVdCxTSk7Ve4AIN4EeIJGXa8xfUd55bTNW01OjaIaSBSG
         125CpEF+9NM5auMSheIxY/NVuf8CmvMFJ61SJAloSA1VacgNCtfaNCuVJgQCSgwFCjEh
         +KWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=mUbjaSPfDzM1LTYnJuLF7ebQn6HhI0dl4kIMWRn1/oCPqNZ2F+sbrSYNh4xcG4r/oM
         HHr3L13QfTeUnDFgDCQo/9AJxOdTcwTr2gn5+T4e/2QpSizXOiualmykW3+KS246UhgO
         WNrX7o5SvOibTjzaTC9HddPY7wTW8QEuo9oH/YkB0ZP9lHUFFQ4pdyRyhVwwEdCxhq8H
         fVyRBSYdYUWIMT84/sulZg0OCn/uj9549Kn9padhjuWMqsRrKe3fdkamRW2J2oIINpXh
         zPazRQ0EUJkb3gZSWMjExSJ0grF+AzabuikevltieaDVtFxJZwjQdJuz0P1dmTzKoOGT
         6h/A==
X-Forwarded-Encrypted: i=1; AHgh+RpY2X7VKgGrXs0Db30PYkC6YvIQlB1Q7L6ueFKyBVB4w4jqFyFn1sWL499/VgA3RrHdZ/sIGs3F4as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWLXQ05h6S7XlbxxrnFtn+pStCTQwPICXw8j1MqeT/ozwMF3L
	OM0U+Hbz1Fzn6XATbXbWaBxSHiwrPheePz/BmXC+c4ouLtNi5Z8Nig8LfZQp9p4nM0O6aXG1Kij
	LqrZi8s7xdRXkpma3Id7daps/QhT52fg=
X-Gm-Gg: AR+sD10SVWuFJOfXqXPGIle0UVpTASAM5MMnVRUCDtMbpkzMbAHPtY478PPfGGWDQet
	GoR5N5i4Rgo158aD/gEGgtnwLTeoWXo3DTjkY7VB69FR6Dp5jXMfonvEnZmolpi9GkoseZpwfku
	Fg0CrtLnnTBJkNHegF1fHpWvz161ErWDASOJjVA0qKFQabnmEVFas/iyGpgCXmVbTV2GfGidhvs
	8mN9IJUTg/RIqdyp+GFT1YKRg8i/uYTnFDcY4/R1/Q+vq8n4jxvUxnyBeXaEvDo0ILSl6zzOcv2
	YSYJ/0KqiA9487fSlOS21wErRApFcPlssm97MEbU9Xh0NwAdYzkNDlNvyDAfYVcTy/9z79yNJwV
	bHCM8JXUtP+iwf36ADtn6sS5U4s3vsIz95abtTwKposxxm8TY2I6TSvIoa1Ws
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
