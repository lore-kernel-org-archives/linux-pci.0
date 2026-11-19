Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050219;
	b=WfqFW0h+TiRDFEeNsQrou5WL56vDBJghQ/x+wTjGT71W67kRrWmdlI81S+HgjumqPATa
	 VuFUBtdfy6YQR3KAG7yCbY6ENDh5EXdYTiZad2rkzKbQqMbdxOvTYAE6qw2wwuIJHuzfF
	 IlmGrUpUOxUksJXvoIeSbFCwmanVXLZ8SbuKU5hr6YMgt+fzYOpaurziJFKmZFFBGa+b3
	 nnhVUcrDPGK3eqXU9dRVlv9ljXVYgdWnkVFAj6bwNk7oWFgi4dD3kQDrS39xlQ8rEkmtH
	 QGEwEBBYM6YwkhRB6zx8l3LlTqAJ9sVFlAZ3QPuDGJAO6bIKWNC73anTG4WZjwYsguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BaPoYSbIyDlQXZcSUegLWZ8oW2t8UfS7havD4Ue3nPc=;
	b=rk2c98mohZ/5C5Md9oE4BLaO5pa1R1mQX1LQyKs/qGcrGNzpZHQOIED/A1dyRBBxkN4V
	 cbpPmgIbyhhEPJ4buYysJVHWnDxdht7M0uDCJK3bIUKU5zUjOzxddRudb9B8i6wwK0Yd5
	 0x/iCBaqKgGQhU0w/8mXoyb++6wO/2qqWJbDxxSKFR6BnsliBPOj3TsMGSQIiXmizFvPa
	 R0XnttRjf6VcrIiECxPaKe1v56Y1cXxkLJNH4Rt0uv0mD/MdrwFH1mKew4lXc3WUDiTHE
	 WJHjHZ7PG+QaWXwmkvngclG0daM8mZHOwUt6hnKi/CPMSEKFNoUzBVC127FJ6v3ZzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uldwb+Va;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95872606A31C
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 01:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95872606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uldwb+Va
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6767d92cde6so1816854d50.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 17:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795050217; x=1795655017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaPoYSbIyDlQXZcSUegLWZ8oW2t8UfS7havD4Ue3nPc=;
        b=Uldwb+VawTnK8K3jJCIdkQhT0L/siqbPW9w+yl1kH2oozPuqZQ9bLnh16nzT4SmGDq
         Er0mz1wK35PbgohcnosQnNnyUaI6+98hLeUXkSBYDQ5AL1rsEtZbktAe2m+t6hGcd2GW
         N9o5V4SgPySoQvyp6xtka32Etm7kvRhp8sMlA5BTr9H7JXAsy2EW/4iYOq2UN84GdQ16
         Wes/h+wxCol/Sbdl+phf4Il+dTVwRBznOITbty3YKa6yaoG0086KXwk68iw8SBlyUi7Z
         +o8mefwkCEdpUca92DeF4p7yykEdeAN28FzCuvXuw2KZhmnTzwhNnnT2ZewoOswg5D+w
         3YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050217; x=1795655017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BaPoYSbIyDlQXZcSUegLWZ8oW2t8UfS7havD4Ue3nPc=;
        b=rE5R/wO2Mvwspf4ssGP8d1d24IZJYQvj44Ka70BlkiqQPy9f//4DwVjiUoLqvuB9Wu
         eBtqjx2rDlqHF10DTgdPKKl/7wlt7iOb0pBWbpQyTJtMmrMLsVQmNis/1OQ01Bs4D7eK
         j75a0WCFi2NMGORe3SZB1AFFvtV+PlFMimdCYiAJ8r6QP6irppO+2rA/nMcUbIqY2CoK
         hwIMP8+gqf2ct3ik1xxIcHDxnorZ/omcDMww49YdlNAMdbF5UGJowIv89AJJub2ajCFX
         umKsJ6Q14x1o7QZlq5v4CWKXI2RqJZQ9k/MxdkiWJyzXzTq22wxeo0HLiUeHxvHH/V6J
         jFdw==
X-Forwarded-Encrypted: i=1; AL+hErGZnkXcZOYHClDzC8LiN0piKF4TrYARAwdNIA70YI+osoFaOf7sScTM1rsoUE5s+m0wvmcU3zsZ2zY=@vger.kernel.org
X-Gm-Message-State: APuU4Z85V/xQsR1DrJvYk0FqzTxSVoFHrgxkNBVaNBrN+g9A9pP2pDrg
	tFcIp0ArCLXEcRQKswwVuzNnWrNJmlsafVgem/l7uDG7nCIAlaYu8d7dPtarUA==
X-Gm-Gg: AZFdTZdD9NDwVtaWdJwFPdk+s8x5rBzZJYHFq8CZvbJzaIvsNcsdQuNKAbmNnkvYj6a
	rieGVv/fyCFHGwHGBTO+sqJlWRTxt73ceLoCgc2IWEIoVRlimFNQmFbLJb5RO4k4hfxsUPknfhy
	WmY9rdb2kcpAVX2oDC1TCgyxtBAZs9jcEnABHNch3DYeHRh38jDN0fU4cnL02dMsM99iweR1c5r
	OkLCqsKZ0MrB/4LKu2bNI5BH+G7KVLo2aTs+j00LCFNzzaSQOqM3tc8lA98ZAP6DFdlCD4rOF6a
	s6XPzw3c7bI9FWapSEL+oRIE8H4YFlnru319mLczIOcwpIZbFsjNOil8JLi2b9mB5+oQMz0CAFn
	dBPnXZFvp4UsG/gpRU79rQgT4zGjDor6ov5GaZ1qK+iHMR5M3/0O4fsRqTFRGbceoVKuZ8rvMtm
	lpa3h8BJaQfOw2hJ+gl47RbZ8zweojyxLFCFfxNHzq+n9gA2yW4LwtkDsNVLc6ledvSbTgbilTQ
	WGyI99jjWk9lChDHEr45SxfMDYjI50nfdLxq0g+RQ8orH4YOKuSGpoLdRxW0EITO+BqvdPh4yJS
	SQ9RAZXhAGflJ7u50iWTC280YUNz2QyB/eQ6QZbNXmOEwnyFEcOkv6bNvkqQmqaX6/ELcoFU1+I
	vaHuYVkKfcIj3Q4mVz8fLw2ZQp/7J3PcfeLqmTcHj4mDObQv9w3SLv7I+Yy7epdNPbo8bvKnmDa
	paf6n8o3rkPJWJYv54BWbKKLA88Ud9qZyTnXEjW1aJj328PW8B+eF38aX9Cb5XTNqoD2B7I0CIg
	YN+hJCe6S23ALhS5fk=
X-Received: by 2002:a05:690e:bca:b0:67d:e460:789c with SMTP id 956f58d0204a3-67de4608307mr670582d50.88.1795050217400;
        Wed, 18 Nov 2026 17:03:37 -0800 (PST)
Received: from localhost.localdomain (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67de9c992a5sm127476d50.8.2026.11.18.17.03.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:03:36 -0800 (PST)
From: Jason Perlow <jperlow@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Error reporting for AER-incapable devices
Date: Wed, 18 Nov 2026 20:03:35 -0500
Message-ID: <20261119010335.84545-1-jperlow@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
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

Tested the full v2 series on v7.4-rc3 (plus out-of-tree T2 patches) on
four x86 machines: two MacBookPro16,1 (Apple T2), an ASUS ROG Zephyrus
M15 GU502LV, and an HP desktop with an Intel 800-series chipset.

Before/after with the same base kernel built with and without the
series: the number of devices that have no AER capability but have all
four Device Control error-enable bits (CorrErr, NonFatalErr, FatalErr,
UnsupReq) set went from 0 of 6 to 5 of 6 (MacBookPro16,1), 0 of 3 to
2 of 3 (ASUS, which needs pcie_ports=native because its firmware
answers "platform does not support [AER]" in _OSC), and 0 of 4 to 2 of
4 (HP). AER-capable devices were already fully enabled. I did not look
into why the remaining devices (for example the integrated GPU on the
ASUS) stay off.

Thunderbolt 4 dock unplug/replug on both MacBooks: no AER or DPC events
and the link came back normally. 10 suspend/resume cycles on each of
the two MacBooks and the ASUS, plus one 25-minute suspend: no AER or
DPC messages and no device loss.

I did not test error injection, so the error-handling paths in patches
3 and 4 were not exercised.

Tested-by: Jason Perlow <jperlow@gmail.com>
