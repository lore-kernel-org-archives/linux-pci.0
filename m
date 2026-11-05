Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900451;
	b=mPS0VXSaDR61u9Q/nqt8WUr4kmb9XU3RyQ6JG3sBSCwpZcOcKBBPALI/kjXdNymIZC+V
	 Vvw7fKqtjZVZP9Rf63qeO7IYJaZQEtmeEFbhcLAaV1wVIaN7a/hQIOEyTa8msFHiwXlYl
	 8RkUklZal4T2sFcNkDUTjNxpR7zd2POBh6768q0ou9wszWahjvUBSRWNtJL9ZQbIHyR2w
	 imnDggfAC9Jm6TSPZ9QPMxZcYHmXHroWo1GuxNnq1q6cOr4HXxdN2o+OSl6uHbIFO51wI
	 /gO4s6RxTm5WwgMSBt6HCJL9OjgZlYGtnbwDURyYKgBAM0NI1u9wJOxjgIVJOMFbOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eAner/Tbdm+vBmCGePnRT0nbgyxjtQ03gRdPce+YEP4=;
	b=UVLemY2tDozpI1nEvhr1QIKixiN/HZ3+WM1YRYeCQpfFR7ZrX1oX4jqOfPeqYrQ2/W1R
	 Cs9N3sX2Y5oacdjyXozoH++Qsq4t8OMX+UUJ3NTnPHSAVYNPqGTiF+PW+KJWCBf4fNfMF
	 9oNk2+i0TAnLEOexkVTr8bLFCywdJBZoYJocecVRFFF0xja++cO5vI1vSVJghWj9WaNI1
	 639WFhagAppkwLFYmY4CJbHgdPeFPegor12eU7vskni9mKkuhvMWIb7iN/vxqMBZkEFy4
	 anyy2EF+IpwAhKgcbc+i5VtRSo3OdUn8tZI5mHmGZwAFfAyFahZTWxBOjr2U+Jpp5tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdSQkgaj;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F045606A336
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F045606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdSQkgaj
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so10560315e9.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900449; x=1794505249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAner/Tbdm+vBmCGePnRT0nbgyxjtQ03gRdPce+YEP4=;
        b=xdSQkgaj+H5AncEd1pKhW+t4h7JEgw/CiAuYSlUcaAbmZptKO9r00mubwDIf3U5fn2
         tLvAkLTSQKneChAZWUYnQbrdz+cZNHc/ytMh+H0WV795twzPSoJEzXGF7pcbKAq+LQYF
         kDTKxYNkxoicWq2MjD/bDC0tBxSis8nn08bKYVxVVImZ8PohlDQXRglOZC/8b5pj5ra/
         A2sduDQZK36rZSSNQ9HGGvfBvdTiEgFzzdJw6U23RHgVHgtlFAKwh4ZXceP0WUt9A+UX
         u4pjWFLhXWtLEMf+pRKdtJ298t1A5NGF5tavyWxW6dxTMJbdmX5AxQtEtFa0Jf8a+Tou
         qOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900449; x=1794505249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eAner/Tbdm+vBmCGePnRT0nbgyxjtQ03gRdPce+YEP4=;
        b=JpukdFmnEOslgOTUlLP9cLyyyMywg0uFbRreYylFALkClAJtr0qasFjUQPCx9SPQ8t
         ejl+NJJhk6RpIx+ILkSWLWu5f5Q9VntMg1eqfEvNt8SlPqEIj/24O5dXCq++jDfzMMsa
         CqOJUjfoSCkXxbyQdJKF7gcYGm/ADlXHQ+Gv48s4BlSQxDAxZQ1PW3AFqhSZ14QDrnHa
         5ftp58nVBF5RXdJmwFA3kjB+3ew0eNUAXYbTKh9tcXZ78k5iuwSVQQ5uRY5AbvEDHfm0
         1vVzdfGR2xGW6gwaAWFr76sQP12RGtnDa5clo5hZ4Vo/Hwk1P5RKYZ51GQPvem/gBXCn
         t8GA==
X-Forwarded-Encrypted: i=1; AKwUvBzO5ojEnG+T4S85cv/o0o9jIDEIAD9qYeXPF4JuuGCVhPB8h2QdkHJArdcuczNTIjteiv4F+rTHnoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z98UitTvrxan0B4A0IFW8wFc5JQ36J8tfQmjZlcg3N4P8B/j1Lh
	9BZgZN9sPQLLX8pEpBPCdCBvonrla21zcFzNX5ZK/Q7jzXD4R63e3/N+
X-Gm-Gg: AYBFou3+hwzoDQkhzmJZ6vDdIA4TT5rIHod+0qXMiTSqWuywsQcMdvsMxQPZJtxHUtG
	cwOWuWD7v15zeADBN4WZbsHBw87qDmr7HPwbMqHvFIVjKVisnQbqYcsIwd3ZSDzOKNpaMSn2WtE
	4PrIooZ6ZOZFI93qpMSE9tlEBqTFAq6wZuY/2mskQuEuls2oY6RQVjpQK2Uf+OqznxShx8gqrdw
	bZQa99KHg+HZDk1PTK5KaMQxdKS4D4ycJHV1TAHfZvGHhU9KLlnjRfhvH6K6QElZxpj/uHoh9iO
	mh09gIqy/izNhl9q65e1AS8A8ZCQPxY+hrpt2NFUPwSnyh07jej4LpfBqwmN/CJip09PF0WU7qh
	OwW+gskdac0asPmYFv/umarTU8bNoeZtLQlSJfy9S1xwvYC4RIDPm2j/wi4+pRsLQ1oa/vxD9jP
	hY7ZRMjqzpR5gTel+Ail4dP0shA0vmuHPG61LZ4k+hueqvZXsTvYYvqmo2h0TqExbAJBzG1flZz
	m0+nmgupZoPVm4vvmLOdTzqM1sRYi+JBdMybjQAX1DJDCWBQ+iqN47PlCsKNGymmPB3Ghpd83Jb
	LKvLXHZzo6LsjxsEJdm9TYnLTu9ej98AXfbwd3GZL8n1WgeNVg+lcarXti148nlhnj5n7WToYwU
	eof77h+cVOLfwrlzfJRTE1rG5TKxMLwtf4vLbo5+Oy38zcw==
X-Received: by 2002:a05:600c:5289:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4b55cf2fcc6mr61403365e9.6.1793900449296;
        Thu, 05 Nov 2026 09:40:49 -0800 (PST)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm81216185e9.1.2026.11.05.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:40:47 -0800 (PST)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: krzk@kernel.org
Cc: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	iav@iav.lv,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: rockchip,rk3399-pcie: Add PERST# inactive delay properties
Date: Thu,  5 Nov 2026 17:40:42 +0000
Message-ID: <20261105174042.2307139-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-exuberant-finch-of-domination-3fbd6c@quoll>
References: <20261104215848.2087944-1-ehbello@gmail.com> <20261104215848.2087944-2-ehbello@gmail.com> <20261105-exuberant-finch-of-domination-3fbd6c@quoll>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026, Krzysztof Kozlowski wrote:
> Vendor driver does not matter, it is antipattern. Do not mention it here
> as reason to do such change.
>
> No need to repeat the diff.

Understood, both go in the next version.

> us or ms?

ms. The 0 case is badly worded: the driver never holds PERST# for less
than 100 us, whatever the value, and 0 just ends up at that floor. I will
describe the floor instead of giving 0 a meaning of its own.

> What is the nature of this timing? 100 ms is a lot. Are you sure you are
> not describing RC delay (we have bindings for that already)

The 100 ms is not something the board needs. It is the driver's current
wait, T_PVPERL from the CEM spec, applied on every board. Because PERST#
is already asserted when that wait starts, it is also the width of the
reset pulse.

On my board (ROCK Pi 4C) the slot supply is regulator-always-on, so power
has been stable for seconds before probe and there is nothing left to
settle. The problem goes the other way: the JMB585 behind it stops
answering configuration reads when it is held in reset that long. A wait
of 0 to 15 ms enumerated 17 times out of 17, 20 ms once out of 3, and
100 ms never in 5. So the board needs a shorter value, not a longer one.
I do not know why this endpoint behaves this way.

Which binding did you have in mind for the RC delay? If an existing one
fits, I would rather use it.

I also plan to drop rockchip,s2r-perst-inactive-ms, since it describes
an OS power state rather than the hardware.

Thanks,
Enrique
