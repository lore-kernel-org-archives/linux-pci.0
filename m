Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514367;
	b=3EjHJwH7qg8kjFq4o0SRfyaXeJw6lDAGysLUsVwmME+cI4SKtgrtkitgPQTk4QCBw/vR
	 9DMXJn72Gku6Pnl8ary2npueptPO41o7FLu00lD49lS3d5I4YHI/Ultm9SwrfnVgCVrrZ
	 tmDE5xaKPFQzru+75alrUJysrCQAvXG7C0DNydyMMBAQClTv9IkMEjcD1lSfZeVXooPS/
	 0685TjafKb51fkLeRjpsR1mqHTW0d+alI4xCWVhW/VWMQ6g4rWsty7PgUf7gCfvMTn/FK
	 gH/uRSBm74dUNn6Q6Tp5aEYB96TLDarlBofls3XnDOX7KCZgWUCYFjmvHEHGpwbVUKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9cdkm/1auD8QI195+wns4rrwS9hItJzoaOrK80+ng1w=;
	b=J+XTOLhHTN/DKNn1joyM/8qfQqQQ3KY6dw5OuCvzpq/gPtXnH7mSSCReaPDMBSekH9R8
	 g1qn8KikORDuzNKU5hZ0Pn31XDE6C+6bQ0uyDY3fWEv6DZQUrh9f5JVyomfL8oldxoVP5
	 neKSN2eJ+XNRzGhU0zW/Wm9v5cNCabdxttMPsdDOh7uc86VNn4/hxjVhyroNMD0PUZYWm
	 Yqp5k2AI/c1Hu+V6afV96Z8opxeUpMPP2oQTsj6O3JxUF58MdxCvuIFe4VQZL8Gj4CKkU
	 C78e2cTNdxF3bzgXDKjNnfI0E58l9lI06I85qT7YEZcMcxYtAam/PCbUg7qoEQbcG3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=enkbmR5N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AD606A333
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F4AD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=enkbmR5N
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33c10faf6easo385401eec.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514366; cv=none;
        d=google.com; s=arc-20260327;
        b=oNLTCtCDTim5Ytvk+q5/vV8hZ03mLnRq3F27oxAnC8HsIRPrDxoRww7NQScBVud9GT
         iQIGbhdy1+zjIkU/UBb0zS5PIX8La1NZqmEjZlRPXeR/v8+TAEmt590nT4qFmpBSKmNq
         SuhtMIRRBc20Juau9FNiPINBOzFHBMUCP9NAuDZtKld7A8NQOKUPDLacWOcNt2NQ9R+H
         pwKdnrUR1m+M/8woFzlDxpsviDJju7uzSb52kQ61UFVPwFTApA/mgJIdTeFeeSgrizUh
         ZUcv5Rb3uYlq/6WzBGDAuEowRQvHlqqB4MP/OMg66kqiTdMI2eEaa8KxOtXCs9mxmzQw
         jllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cdkm/1auD8QI195+wns4rrwS9hItJzoaOrK80+ng1w=;
        fh=7icAvTm6uafgf8mzMzf1kAP0Oneh7ONFQl+VBw8RXhA=;
        b=dazQMYzSPMpYkmFAm9k58UzWjs8bof0S2butmnvO0Rrajh+/UMI2tMs5/S08hxcre0
         XlLpmd1k/NpmSDAVOj+3YZZkly//L45dMFJxSmB66B5kBew5WmuebGBg5Ki9ND315fz+
         PeE+E0Nod8M2Yv8t5tmJIu8MZBGtIfK/Tk9wall8OP7FU1/p7+ghK2uV7SE/ogb8kQC8
         qsat0knijbwLWgCPSS7hsLs9e3luAbTN76HIoeyiBG1eN/Zvi/GxfYhapvf2mQGakwKy
         zrs0PLK8idVDBdv8T4L7eoBFn6UTRHPNdqij8TNHUaZcm9od+dwIG25renCu8PJRuUzz
         LC+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792514366; x=1793119166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cdkm/1auD8QI195+wns4rrwS9hItJzoaOrK80+ng1w=;
        b=enkbmR5NTVbQ3UrlQC171YQTmcaAcweChXaMlD/dH3Kb0NdENuVXXvN6HdylZ9SxOc
         YZDdTFSVaIlTSe+WbxvtGwjaue5Oso8RDImcyW75nMxyHJv4wJLaVJYMckH1jXWy7M4V
         jjVwjSnIkX7ngKBx12o/x0jHhkNsYjaMeEqeYPTlLs2s7qN0vYhvrJk62IysjOGbMHXk
         BKM0oi7e3qstE3umQzjkF5wcADd87bZr9CfbK5CVLXuY0F6yh6vIT1l1N8rExH/j8BuO
         OrzSzEVnZbIAFyjMi9EAa+l25RIvlyXNJ7A3AT9Fn38GUnYn3ohZjgFIHOUUSKMmjmwS
         d0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514366; x=1793119166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cdkm/1auD8QI195+wns4rrwS9hItJzoaOrK80+ng1w=;
        b=ryRdAThQ/NRLr+Yji48HQFjWsU+1fDwjOoxWlqcntGRRrPvT2BPuX+WwA5ZlxACU2N
         Xy+wkDvRNYQj+Hx3gQXGBYPTVjI0hDTYHRg1bz7ZqqFFe972lKBXDwgTiZQ34omG6OLV
         h7OPkegeoUguddunfw4tcZELhKlqOxK37kCKFhSr/PbnZg2AWrnCs21s4AQms1ipEhNP
         PdWkmvuPvK4p69VukChPZSBxYvNeCDNJxcnYIt931HpL+1KUcpzzPwQdtpWP5h5FL2XJ
         1GWN/tTkuhFgtTMCUevA+ZO358/4wPAa5o1nq4R2O9xRN8xOffTKzRgoTjmNtq0wZOOW
         JCWA==
X-Forwarded-Encrypted: i=1; AKwUvBx1ZATbYEfzObHeCaxQ6y1+kbqWKwM4EEevQP+Lan88zjlc59fQOmrA/H5h7RJ0sczYprFkeIMHlG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyRvzVFdS0sj/X12gcQS1w5ukbDABYnJ8wHhwPOrONu2iWSW9f
	8sqfbs2R0Eby/cDsAdMTZpOLUiLHjfJ5smsMyZDC5UEtjSByUEq8Q5tJY7SaKhxveu6QLCLY7I1
	ZmkF4wXczaZ6iTX9/6nyapriECJBS6/A=
X-Gm-Gg: AYBFou0zMOUPeSkA7DEEWJs/fI+g0dBXsHsRQhzsOhXS+fwYD3P7MAfZEd8nXsrjgaC
	EawLcHN3YqVWmM2xJHwV1xVzBuMfoC4mPQINuOhlUMwL4ZJp2eRdBaP2IuVJ+JiU3gOkpk+G2XU
	0p3+k5E0iEBxVF/+gU03LybJYkn97jddgLf7mDn7PJHXrnRWGL550qtU+THmVu7aDrgE1WRTiuv
	jom9suRr7zfnEXmAii9TkNjh4BL4AloQAefjagfWwPDmGI2CfGGGaBZC3TeI/SI1/Qs1NXreXcH
	2+OQQCAE+3RhsO4VqHQPXOGRSZxDmyidK08HiQB9GHvpxSjeae+yy3YZsdnbvD6gxKVpqvU2wrH
	vJunx+NvlNX+Q2Dus5AGUGFsobrXT/2pykTtfgBUaCKWJWBO2pxAtD5SF+kSzbdpaPfegoGgWcT
	anW6/KT89zNv+sLerGKChsTFXE3QQ0Q3C0g1TNkaABDX8gA43N57Sj1xfvAc7aLFbpawI08pxZX
	rU3B4s6fM2pKGnp8AHjBX9LpVnTHqFO8xlg
X-Received: by 2002:a05:7301:da84:b0:351:7e15:9c59 with SMTP id
 5a478bee46e88-3619b30919emr24534750eec.0.1792514366275; Tue, 20 Oct 2026
 09:39:26 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-4-2c296d8a8e5b@posteo.de> <20261019143818.GC2663669@google.com>
 <236149b4c90323f412d6385c034a78908013e2d7.camel@posteo.de>
 <20261019160407.GG2663669@google.com> <14fd9a916dd0792a74ca01ae073e714f95a9c780.camel@posteo.de>
In-Reply-To: <14fd9a916dd0792a74ca01ae073e714f95a9c780.camel@posteo.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Oct 2026 18:39:13 +0200
X-Gm-Features: AclHuK8raElhkbPr-7bZyBZSZrGqtKLbWS10csaRXDChmKEDOAjNZ5GlvVMRpWY
Message-ID: <CANiq72mRvmHOM3wHseReRXUCgpWh2Qzbhto5LqG+eOQ_pUGLGA@mail.gmail.com>
Subject: Re: [PATCH v27 4/4] MAINTAINERS: rust: leds: Add rust abstraction entry
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Ira Weiny <iweiny@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:23=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> drivers/ includes rust drivers. (e.g. drivers/pwm/pwm_th1520.rs)
> rust/ is only for the rust abstractions (the layer between the C api
> and the rust drivers).

Yeah, and we will be moving soon even abstractions out of `rust/` too.

i.e. there is no difference between C and Rust in that regard;
subsystems already own their Rust code (unless they explicitly decided
not to).

Cheers,
Miguel
