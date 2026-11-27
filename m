Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797103;
	b=E0X2KkkCKYYgtBFvQX5rTxmsf5okaE9X8Jl3lczehDxc0aJ6dTnq8YI9r+Q/bRGZkFGn
	 Nf+6x9Df6gm7tC9X5D2OQxYc6XnWy20vKu3irTZvQPG4qOJRA67RgKDjurTTCXpY4FlIc
	 SPFQ42rUBnQkmtt9nLnYMerrxYqYEOM6NOWCsSqiJjj5ihYLV9drQilzmFRmZ7ITLdSq8
	 9HhFD5NCcUAOVA4MaQyPeOoVemUp9lF8CbaTOAtYmktzSp4PYfdBktXEv7IUCBPiLEVNF
	 d5h4m18dlRbQpKoOyEVEWEKUcc1Y0FGnsrIsyLZJS+uZyk/s8EjQXHnGyO9taaKgE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
	b=e/FuTcG/A9GECx4zJaIXeEIsiyoOBKBZLF02XF6ToaEN0DgYMQmK+wsark6YNjA90xPI
	 6po0bh3dFa4yLCkOGnBHM2j+/4upt9UF95Vi2ny2Wzk/qtX8dQh4mIkj1j/0iGX/QZb6X
	 8WW0jhIhz79GjgN1XQFo+t6agG0Xw9Z8x1m9zm4u4YVsJMgdOWeN3GxWmxGcP4u2dOkKb
	 jsDJJGotK2Q5/EMf2vmUEhYjo57qxsymL5I6fGNKQr30aXbngMTkn/ppaXlfPXOOYS1Q3
	 3soABV5gxZLe4wLw2X/Ccn3FbhxUheZJWBhGxSftDLw1638Do3dvl1mbO1s9SP+uBLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p41YKBnh;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEB606A31F
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 16:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BEB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p41YKBnh
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-98301b325c4so2396203241.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795797101; x=1796401901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
        b=p41YKBnhuyOT+TpvRIHrMxScjBU7bBWKCDfLL0udUkj50hiYT7nd821dY/PTgq6Zqz
         YEgrBb02dHDhK3M8p7WSqluOSGQ94A/hj6um6azi8xgzJmejaGASDlqysDAmUnqIuw8E
         YTAr+gTmSk+g+TKbhv8+qD/tqAklezgjEbwQHVkwe0iQ8/m3qBaQavkXPZBH+NDykzyr
         GsZWI7geCD3MmYYglHrpPSrKlWnZ/y7Gdf8QGZjM9mNuiBR4OvIUI02U+wEDWW2wFJXu
         2GR74dMshWTG+CAgfL+L5QXyjaB2nVMXUIj1nl7jfccm7WQqAdj0hXei0CLhKI1gzf6p
         f/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797101; x=1796401901;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RPYgSF1XDHYafp5XjEHe2Hos/Amzm3Q5tQ+HDP2AiE=;
        b=NCLQzeGfYvsJwrGxFTs1RMC2qiohUX5xmmr13ILKMsHCbSnEkeN6daSU0Q736530Zw
         soPxf+NaMtqgL1PUPvKAOl4M9X2eBNYO4cHv/UqiEsBf/TMKapRTsavNPOOCvw25WFuh
         lC9yCTzM3dvU7FNweQeHD7AbB70TvFo5TBneZYee98q+zBs0swfkYI6ua3Ir7aNddoTH
         njotni4e+q/C/UQcCKP/RfEdJwNzSG9pOhzEn6RDed/xheSYixF4D2BlyANXQ9zzUxUr
         ahOe2GVxcjJoJRM7JZNPkL9YfulBVNa/TXSmwHaNlEuJAPuwBS1ZMwXEhQ2cBPa3jY50
         wvrg==
X-Forwarded-Encrypted: i=1; AL+hErG+oduQDd/ztBmvQod9pNR+Qnl4xxd1LbbR6npv+xdPh+svaa4e64eiWJcjJ8biY8kgKkNxBO722RA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ef1reTUcCgZ9T6np6zi+HE7CCG9MClYH//bszANU0SBtH4lDE
	Q5JjLFDR0Eda8kQfBWwv72MQZwZGq9s6TbumLtw0uG65B/D7fAdw3RAB
X-Gm-Gg: AZFdTZcE8wcUBPLhQuPukiHwXsIDidMoKPW2/jyOuepr3lrkGkuQeukKBbOrEVDBiTC
	lcHYqpdPQ5j+4KzHF2WpCmYnBGPRQD/Rw/ZqVajL6hWTxxidGalZMg/pMzNZuoLpA1s2NAmGVZb
	5N2w3yH4tSPEqGpEPb+3jSCfgz9h/elCBnDI2GOfcEIjCjiB69ajNqRfjWdjQn+P6CNGQ97bYXY
	Ra6y2JwAARVRuAC81mxjwaeXWkTkhd5a/xoDHen0587oj4KPoINsCyXjEePw5EASoaNhQo+RJVL
	T++4iL9ur8dNQSHkTZLEj2IIaJg+J4hzDkyDjPaDFT5BFP72kxJbOoau+QXHVJHZdZk0vgeNeE1
	8iiTayCXX8uoroWWwngVQ1ZzqHRHRYcl/i/KWOiWXnDlWOI6GFycLP8euJ80joNXiJxlSUfLdVS
	XMbfOmXJ+hCvcQf7F8V2IT8GvOO9fm/wVCNMbBX8UypyGODqqPu00qEEv+8unYY5rVfbK1w93WC
	Lib+VFpmBMOGdx3XSpZVneCdjFsl5mkLQwussKTlCl9qUY7cnKkGVFE0x1mpN1ZKXN3y4sazMqi
	DbGmVvHwsnvwmpAqyNfGZYCGGIXw7191C4XRAS/xxfRZe/U=
X-Received: by 2002:a05:6122:3b8c:b0:5ea:f220:fd6e with SMTP id 71dfb90a1353d-5ee8aeefceamr14730581e0c.11.1795797101340;
        Fri, 27 Nov 2026 08:31:41 -0800 (PST)
Received: from ehlo.thunderbird.net ([2804:388:90c1:771c:18eb:ef7b:e7f8:aab3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99eab8e7b9esm10043528241.3.2026.11.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:31:40 -0800 (PST)
Date: Fri, 27 Nov 2026 13:31:35 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: linux-perf-users@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Sizhe Liu <liusizhe5@huawei.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, bhelgaas@google.com,
 yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
 will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, wangyushan12@huawei.com, wuzongyu1@huawei.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@hisilicon.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/8=5D_Enhance_TLP_packet_deco?=
 =?US-ASCII?Q?der_with_field-level_parsing_and_versioning?=
User-Agent: Thunderbird for Android
In-Reply-To: <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com> <aqB37YCMUYKodo3N@x2> <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
Message-ID: <D6C7F85D-0A2C-4569-98FD-ADB616FA106E@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 27, 2026 12:12:14 PM GMT-03:00, Suzuki K Poulose <suzuki=2Epou=
lose@arm=2Ecom> wrote:
>Hi Arnaldo,
>
>On 08/09/2026 22:02, Arnaldo Carvalho de Melo wrote:
>> On Tue, Sep 08, 2026 at 10:05:01PM +0800, Sizhe Liu wrote:
>>> The original hisi-ptt-decoder only prints raw hex values with generic =
field
>>> names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
>>> DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format=
=2E
>>>=20
>>> This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
>>> decoder in perf tool to provide detailed field-level parsing of TLP he=
aders
>>> based on message type, and adds a versioning mechanism for backward
>>> compatibility both in hisi_ptt driver and perf tool=2E
>>=20
>> Series is sashiko clean by now, has a Reviewed-by, but it touches both
>> kernel and tools, I wouldn't have a problem if it was processed by
>> whoever maintains the kernel part=2E
>>=20
>> - Arnaldo
>
>Please could you add your Ack on the series, so that I can pick it via
>Coresight tree=2E

Acked-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>

But you could have taken my "I don't have a problem if this gets processed=
" by somebody else as an Acked-by me, documentation says so=2E

- Arnaldo 
