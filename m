Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477D3644DF
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769883180; cv=pass; b=jkcPBpCQlFjHNpbgO6XLN/xZ7PylaxDLw0jTRgCiQiZltWoZauj1L6zxWon7T3gu5JuggBF/YJMIVrEPSJquexyPYL7UhV3YRXwHjhn+aYCf0j2h4g3Nq0HM1fqyx5xJLXwjWRqVDoEuVgd1MWXzjyeSk5c/3lapV3K7b+ztMqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769883180; c=relaxed/simple;
	bh=doN+YqMCQysthtBcnuNBaL730r6pT6/zENymgqaabvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJnlh0+QRxrIJb22vSpS7YKzsgc3U0y9Ru/ic+PxaVfYCkBJYakOSpEdPpghwQA0M7lV0P2PdSAsw7CHRjFXUw7unaYoQFDxWbEnnaJpUk6fI1iUKxr5ZdC6n28wtkxmJWOnuktEp5hZwtu8oKwwgKglZ4Kete9cl+UXEMSPiFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqE1Ou4I; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqE1Ou4I"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b7267ff06fso140747eec.2
        for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 10:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769883178; cv=none;
        d=google.com; s=arc-20240605;
        b=duQfsK7ME1QEbuBAptYTEDkHFT/L4V1lIir1Mva8f8ZcKqr7nf/neRNhcv0XyDACjT
         R+qrvjGU4OpY1a7wHdzY7WArIikLflzEwo8wYoaU7fqz0e9nLyAF9GHog/vwjNlm8jKZ
         xyRQv/qCX4bqUyeyv5KxTFBCYfIgb6LxsoUhoyBcadV7jOlUEjrYKgIYhPfR5FPnDSph
         dtH3O9Ve4vReAKqk/+uoc6br32o/k8yv6yItmEu7THf7IEFrIWg6RkgdwHmPETNJBgav
         /csq2z03rS46lTuFrkTaX7A2ISsSgzU5/WzJ0KABC52P2Hz2dai2ZaaG6ca3WFwFocIL
         ObGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=doN+YqMCQysthtBcnuNBaL730r6pT6/zENymgqaabvo=;
        fh=K7b/+t7YxdSfjTaxdQVAOC04c6KZgmJHn8LRs2d5Et8=;
        b=Ln2304hfQK2UWja94Zp7x4+FqLYnmnoG3V1C5B/kXDPH2MXjPqv8ZoVEhJPXdlYtCW
         ZeviXYQjVTmOaGseTiloQ80IVg4tL/x8OOIixdO0qrdj8eeOMKg4V017yq6E4LoKXnW+
         ZnRUd/Rqv89+l+49+k2cak9shU6gDeQaSjWYLfqimsFKV3qklnIAZB7nrUo10nEzRmqh
         LfDo2+QRSuupf8wt0U98HnPxv2X/iQ+jkqR8miVLQ09I/bRS4CPMNsV5GwAASjrOCp9L
         mO5KJFRLytdSD+NT7jw8eLZNHQ6kNH87yAtghMNc1z5mMPbmrRQF3OpEw+JCKb7o3gRE
         88OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769883178; x=1770487978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doN+YqMCQysthtBcnuNBaL730r6pT6/zENymgqaabvo=;
        b=NqE1Ou4IuO8QrjHZhrmd4r4/chvx0NtOJi4yqMvS3633gzBYlPUJQbv/kOhLBB7cPj
         J4plQgtA0QNh7h3u2QGmlWK4FlI75Kc0V98jHqh23RHK+Aa4mU3H29Tddqb6ucH1H+ue
         o5NSVJmSxb0H/mdLK/2CgEuP6HXHGid52JZ07TDJ2GFxux58wg07jwugvCo+x1uT9mwa
         4s+Cd4cETIq1KrnkEOJ2DBhAyEDWRdLW9AjQPjzNhiINLpVuNoEPn2kty0huZ1X1et31
         IATmlElGkoGTmHcR/iaMRLHOxIvsKV+EvFvsvL0F/9FKn1ACquGOdkqJtwdTOVw0IBOB
         MxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769883178; x=1770487978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doN+YqMCQysthtBcnuNBaL730r6pT6/zENymgqaabvo=;
        b=VtvNM3mX9YOWBY0ivF+rQesRVSS8FJ0vtZEKPNNlZhVcD6gWy0rTCtElGbc5Nf0t4F
         5AfNHgpokDwmlFiIvVbkOfxpgJ9AVrfk9jIGtE9UhJV3uOqKIWJc5RQgVqWMwZTs1MV8
         5L6GZg98rpCj2x0SG+mAisoAzqjEZFLIBi3xbZvNYPXvOxHYPLh3Ol1v5AZDUpAej08X
         0+0/U+woNvh2ArqUZUNc5ZbAfLTY+89L0RyvAoYxDjMlhJhLrwSGK2GOatD0sYO8vYjI
         xjTiyaY2GoTseXbk3ap+u426hHr/IhNDd1L+CI4Xkq1H1pw3vkXLPxgiwT0K3omcrZP6
         ToTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+tUa7HGi3nE+KtcOPq5DypmRBljKu1KibNnIv7YzIbIWLQwRibM3KCDXBRVXaWDK8SOajZ6HT4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP1GPUYz+VzdAJ3LwP8bcCti25YNVdb1tJz+YJqUDiZdtRIBI
	zTbxBHgxaRx7Sb6LxtshCZ4XSGNl0CmCXKVGQQ0kfg58H/u4YWhxgF5ylgWP9p3zJtjMbZC7+Tu
	bdZNUaDxNoZTdsytWyonVYh4zYVErTnU=
X-Gm-Gg: AZuq6aIambkY0HD3G6fn3CzA7e5njVG/hIa0wZCPNeV7W9/ocSMB0ePYb5DO9EaUTrI
	N4qYYw8eRrnzG9STQjCIa4iBBc/PbbbYYO0vpXh+mF9+KSgFR/fTcMe/v2iymFDJVwuTP9xmn4j
	R/J0baC06c4HyjKF2P1XR3nJqeS7pizF+R/4FmJIuW9pj8iKMsZ+v0pKyhYMWWpnr/fs35nL78B
	CsOOiyaEG0EecRJTQ5jsnYyUHfTy7CAwqzZF9SfXcAGq3JI7nWqLXcE3UA+sUgCvWgkGcrF7+GN
	aVki/bVKzgB8pcmMsdjkbVNgVR6GEHGTZxUNH+9LPKHJTiascLZKf/BMKCCDIWCB2bJp70RazeK
	Vt6iTN+ZVItUEApTdLJ3CO9E=
X-Received: by 2002:a05:7300:6d21:b0:2b7:b88d:b75d with SMTP id
 5a478bee46e88-2b7c852452bmr1622632eec.0.1769883178375; Sat, 31 Jan 2026
 10:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DG2WR3EOBWCY.DU3K4LRV4FUE@garyguo.net> <995384df9224283fab185b5e06f519506fff1873.1769877524.git.zijing.zhang@ry.rs>
In-Reply-To: <995384df9224283fab185b5e06f519506fff1873.1769877524.git.zijing.zhang@ry.rs>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 31 Jan 2026 19:12:46 +0100
X-Gm-Features: AZwV_QjbaNvdhVhrA4TUdX57i6Lhlgp4Gl5uCkJqb2l_YPViRjYzhboypmS9sxA
Message-ID: <CANiq72=8pjjfsAB9Y=Q8TYw9frmWtR9q3PzesXkWn6e=H8Xyyg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: pci: export ConfigSpace
To: Zijing Zhang <zijing.zhang@ry.rs>
Cc: dakr@kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	acourbot@nvidia.com, Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 5:47=E2=80=AFPM Zijing Zhang <zijing.zhang@ry.rs> w=
rote:
>
> Re-export ConfigSpace from kernel::pci so users can name the returned
> type from Device::config_space*().
>
> Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/rust-for-linux/DG2D5ONS18FE.TC7K3O8V8SU1@=
garyguo.net/
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>

Generally, there is no need to resend to add tags (especially within
the same week) -- maintainers should pick them up for you from the
thread if they apply the patch (otherwise, you should pick them
yourself when sending a new version like you did here).

In addition, I would suggest sending new versions in a new thread;
otherwise, things can get too nested in e.g. lore.kernel.org and other
readers (especially when patch series have discussion involved and/or
are long). Instead, what I recommend is adding in the changelog a
lore.kernel.org link back to the previous versions (or at least the
previous one).

Thanks!

Cheers,
Miguel
