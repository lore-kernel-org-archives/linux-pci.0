Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985219;
	b=J3euo4/xahkm3wEDBJy12hgoL5F6vMeQS1mgBQtoCMn3q2IGkrCAJ5Vxpx6YbNoeiSlX
	 p/rcs0un/pikzWWwTkqOeiiGs5/axdKmzJkaM0shGoBI/pBBsQhD75XVXrhLvCAhtTV7v
	 4iA+pZJtqq6YYj4WyEUnn1Shm+LP3eq3m660KZvAgXjPB5egH65ZMQkrLe0v1D1KGbYe8
	 87e4I9WoXn74KLaCMhdfGuPws7CtZrdDezkk+0npelRJ61kA5PU2LzruPStXYSXEpZwYk
	 wzAkVwK/kKZ4xMhpI83UyS7n5Mkb72u1QTQXqt8Q+VGuS6uCxswj6UsOHl47dRmYabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985219;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=LHA50PMi/3O/NM7XNrwERwdhv6v9CMf3cD5rVc48CVQ=;
	b=IDBexStUisbeM2pZ4qs7nsjArf4t5sMGl4AL7ocR+LwAGbkiAGJhSXMLvVedywIRipPr
	 KWFnTF04XRzqkkvMOqCCtPOEWPOkfiTEpgBHX2Y808wJiBKEF0V2TDpOeLMWOL/USzL9l
	 XrDoP8pUAk/B6g7u/Gim002r958rCfN+X/4EIAxX78YP3f5FtUSibuGW8HmUi3cPuZPr1
	 ejD81RyhO88wb5YDDVLIbg2M4YN+804Ng3XxXgcj6GuAQ+zxK7NgPQ2BONTH2uPMVJgCU
	 Aw+7grSuZIQofEJ6iCiM1VCgrDHVRQdlioBNzm50cr+xCiQsXt6VKgTpd9j9lgDPuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9525606A330;
	Fri,  6 Nov 2026 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9525606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLm3g0Yw2z57HS2;
	Sat, 07 Nov 2026 01:13:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A6HDPIr030789;
	Sat, 7 Nov 2026 01:13:25 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 01:13:28 +0800 (CST)
X-Zmail-TransId: 2afc6aee0ab8e83-e5dcb
X-Mailer: Zmail v1.0
Message-ID: <202611070113282050C-WNjA35gRovBtA5ju-a@zte.com.cn>
In-Reply-To: <89d84d22-9c75-c49b-a4f7-4682a80187d7@linux.intel.com>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn,20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn,89d84d22-9c75-c49b-a4f7-4682a80187d7@linux.intel.com
Date: Sat, 7 Nov 2026 01:13:28 +0800 (CST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <ilpo.jarvinen@linux.intel.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <mani@kernel.org>,
        <kwilczynski@kernel.org>, <lpieralisi@kernel.org>, <kishon@kernel.org>,
        <Frank.Li@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzVdIFBDSTogUmVqZWN0IG5lZ2F0aXZlIHJlc291cmNlIGFsaWdubWVudCBvcmRlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A6HDPIr030789
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 07 Nov 2026 01:13:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEE0ABF.000/4jLm3g0Yw2z57HS2

On Fri, 6 Nov 2026, Ilpo Järvinen wrote:
> Wouldn't it be better to use %u ?

Yes, that's cleaner.  With %u the "-5" is converted to 4294967291 and
the existing > 63 check rejects it, so the explicit < 0 test is not
needed.  The error message will print 4294967291 instead of -5; I'll
update it to %u as well.  I'll fold this into v2.
