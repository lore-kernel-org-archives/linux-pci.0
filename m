Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848409;
	b=mncmZm82RSZI47FRK2eoYwIkH2clxcNQ2k5Tftj7WwTtMqb40I287zbLSIENzW+0G2mz
	 7qo/svCd6rld6DCKSHs3+efGNw+ADgCyI4751v3jcV8uolkqp7b1Ubmd+6gH89yZYvrit
	 84V4fo8aRtym3DJMOlJU4j25Wk3KKpCWUQ1F9m+f0QOCR7jW8KRsCuF5yoc+cD0xduRJD
	 QJOXM0TIQAYROfk+tD/JeFK4gNnBoZtOnwYXLgvCFucNFt+xUgFRjQyzQ5cu6Wkh4RX/R
	 3SM67moHPe0Ndu6hs25XT1JLMR8C9a0Q+Dc6st75AaivpUsEq0H4MfJFcf6tYTxdQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848409;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=elWbl+OffFQuIIm3yhMS8vybFO0kHurUhaRvfp7EAfw=;
	b=CwIUTuil/wzroAP7F4gKollh0Rd3XFPoXeZ9WXVMCY9ZcDRyeUa7rR94PZz2BAQLH9FY
	 Ts0YxfsRk5sTnG+kqDdX2Wkmo4t6YmtO7Uc4ni5i7g1nYfyehvTMS6HZPvvkWNmVW+9Q6
	 2ioOzrimTu9l3A9tX4GROqIsciWpejjPuDU0M5xF5XbwhoUsk+2uS7g6VtCoc8AcaIIWL
	 LD8b2s8NE66/7zbaTq3dOZfftpOajGYhE58l+hZPWGGq9xUWG2U6ZR149pdiiK2Qv9qyJ
	 QAQ6jMe1n/83I1MG1JW4kIyzi38310PtvJpUFh3o8pmzUl7fN1rI7TZhhacj+OVwjuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=rd7VFLaP;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAE606A328;
	Thu,  5 Nov 2026 03:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDAE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=rd7VFLaP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793848257;
	bh=elWbl+OffFQuIIm3yhMS8vybFO0kHurUhaRvfp7EAfw=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=rd7VFLaPowHCqUz/0ZqNnCNuCnedb5Ij2k/7h/uKZOENVHl6zdz2w0V2jgdyVPwnI
	 kZkTkbtvtO6/a7bvL58wCmNWJluOiOaxIPOcgECjPKPYGZVls5JwP4+x7yYIYhBuC6
	 ktNKqrjNFdhCNosjBFySIALk8O0equZdRFJqS1sU=
X-QQ-mid: zesmtpgz9t1793848252t934e3f3d
X-QQ-Originating-IP: PzFdMtmjvpoEZUFriSo1/f1E/ApJhGnMm7BqxTlGO+Q=
Received: from localhost ( [8.218.183.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 11:10:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10634412826085304588
EX-QQ-RecipientCnt: 17
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 11:10:47 +0800
Message-Id: <DMMY4S89W1PJ.WWIUJ905SLXU@linux.spacemit.com>
Cc: "Bruno Banelli" <bbanelli@gmail.com>, <linux-pci@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>, "Alex Elder"
 <elder@riscstar.com>, "Yixun Lan" <dlan@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Krzysztof Wilczynski" <kwilczynski@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Uwe Kleine-Koenig"
 <u.kleine-koenig@baylibre.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
From: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>, "Encrow Thorne"
 <encrow.thorne@linux.spacemit.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260825052249.66921-1-bbanelli@gmail.com>
 <DLKRGJBNFVQO.15WZ2SXQLOY0T@linux.spacemit.com>
 <xuafb5qshj6rowe3v6sxyfvtemy4wg2ttqs7lcwu3txu2mpyzm@fr72njh6zgvi>
In-Reply-To: <xuafb5qshj6rowe3v6sxyfvtemy4wg2ttqs7lcwu3txu2mpyzm@fr72njh6zgvi>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M6X4Jj6nmWQyum/iMKz8TxjkkJ7y/4Dfp2UGPg1Nck+98wNvcvLORLQs
	MTB5O+r07L6tCVLtuO8Q2MdhRqzq3TxfbCYqtA8mThs/mJQ42AJCsWlUrjwCKmKxSEB0st/
	IjM7gJMpl0vK+PMSooTN8SVRqieZ9ohDChhZds9zyGQwfDtKk4TQvltDqb+9r330b+XCY+0
	iL1HPFkOuIMKeReO07ijlngEnPv9NVlpprYEv2MMlXcxxS5MCLD0SaCbe3ELsyBUueufj9q
	i+HszP7fBQWcQV5w12SegnqyLOSnvypcpnuwZ7Jgu/+yOTcO/kzScYLVawOCiRNk7qU+/4m
	4/Jpb4G2toR/IWVsOL4uL9sM0yy4EGML/hTPlt/tLUqnceEUCsxsIVnUWOvAzF4Kz292Ne/
	be/SKCQ4e8d3yMAZyYOO+JgK0M6OV7fGiN35oVomkIgnSe3R+1zf1b6vLecf1n+wEev76bH
	P7ireGMJUrUFQ88J3Thhl8TRmVuJIsHY3bBwaGHYSjQWL4jowG6pUBpkYS1/IXP7xByB27k
	edIQjGjNwWIIzRQZunTLQbMYB6A5/Wv/5gRj8Gaf88nmSM54n5K44c1svqCW96ozymjZEwx
	aNP+VCuXVPeulZgLk/NVYczO7u9rrkJ3wGwjkSmzOAQzHeY2EoMOgqgKBMXIDXyGndvFtJO
	25FLZQ89F+jPQBZ+DHVgRICDkuTQ8ff/CMGLFPa5NdTELSRaoQVVCrCeyUft5NIPe6laAfM
	hPXNKGIdq+rjamRW6q7/kOucLU2ryC/KKQgUIVJE52C+F3x0hXXs8hOJu6uFZLA+c3w6aX2
	+bh2Vpc+n13mQuSXsPDfyNKyZRaJH8fdac44JSlLIk4ytcSsBMsBZ1mCSlIB06+ATCh4ePp
	o6IS5E7coP1OgX6UjxVZCmEZsebL1WeTIfXtELzTWMKuzdIAPuvrpRHWfe9WyeU2nMbI0hY
	bE7hxXQzVrocer1d+7Cw0BP3CPTbGcRnrkpXDx8bk7RPCmprqd6HnWyYCqZSMegoHSPu6qq
	HIwRdlow==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Mon Sep 21, 2026 at 4:03 PM CST, Manivannan Sadhasivam wrote:
> On Mon, Sep 21, 2026 at 01:55:42PM +0800, Encrow Thorne wrote:
>
> [...]
>
>> Hi Bruno,
>>=20
>> The issue was caused by a missing hardware configuration in the K1 PCIe
>> initialization.
>>=20
>> The PMU PCIE_CONTROL_LOGIC register contains an IGNORE_PERSTN bit (BIT(2=
)).
>> The hardware manual describes it as follows:
>>=20
>> =E2=80=9CWhen set to 1, the PCIe controller and PHY ignore the PERSTN si=
gnal from
>> the link partner in both RC and EP modes.=E2=80=9D
>>=20
>> This bit was not configured during RC initialization. As a result, the
>> controller and PHY could still be affected by the PERSTN input during th=
e
>> early DBI accesses. With the Intel I225-V installed, the first DBI acces=
s
>> could remain pending and hang the CPU.
>>=20
>

Hi Mani,

> What does this 'PERSTN' bit controls? PERST# or something else? PERST# is
> controlled only by the Root Complex btw. Also, why does this missing regi=
ster
> configuration only affecting Intel I225-V endpoint and not others?
>
> - Mani

PCIE_IGNORE_PERSTN masks the PERST# pad input to the local K1
controller and PHY. It does not control the external PERST# output.
On K1, this input path remains active even in RC mode, so a low
level on the pad can also hold the local controller in reset.

We found a 1 kOhm pull-down on the PERST# line of the particular
Intel card we tested. Together with the Jupiter board's 10 kOhm
pull-up, this kept PERST# low from power-on, including during the
first DBI access. The other devices we tested did not hold the
line low in this way.

After removing the card's pull-down, PERST# reached 3.3 V.

Regards,
Encrow Thorne
