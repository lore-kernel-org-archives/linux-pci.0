Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202993;
	b=fWvz+h0NsKmtr+AUx44ni4+bbZTAUAdF58ah7gwVXiXj/Qjgr11duM/43I+99bpDrKXm
	 PzXHma+ovI1DAJI5QOaQaLjoUfz1qPWFwGEeuWWZIGNnwjS4dCqwh4Syv0kyWJed/Srdy
	 BAhcEkXUr5S/zy6Xee98/0h7+Rd9B8MVKSwkvXeORig6eyCqtiIzSE4poYHR77qYuPqX3
	 8naK4qz7kVxbVuhDXiPbpcuVZeaINjq5yjRTsIGYBOPd6Kq3DQfC8KZPKTQY2XfCUBYlo
	 KMegS+YyGg6bVMg34E2l9zkDU9xTtp67PPnB8bffCH++2z/JudsDg+gKFF/p+bHrcpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=;
	b=uLMEtosCWCBSB3Bhkc361zysANYjW6O4pyNYIM3kuCCDFPcl1ny6RZCRFtRb17sYGGOS
	 fZ9J0/pLMD1xrl2QTRFMqlv98oQALy6KL6oQ2lrU1nth2IKlf1z9nUcKKLmpbIyHm+FrF
	 MiVyAHj0tU5PAuiLmYW8200mlLVaCBumOxNM5+uczVrRBZW1DJbvK2G04YASg/Q+NzqE0
	 HhnkkdEOuCCff49WIFuQRs6juTqlC42/qScwhMrBrUr46JmuxL5JK+V093Jm4DBiw549G
	 Oenj/ie0qXvYUrNg/T0xcDzEhqExknVErejYMOEQthQNukg5FoEpxMFjgb/oeXq8i9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="I5/wODJW";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3E606A338
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 19:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D3E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I5/wODJW
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f02f04a426so10775175ad.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795202986; x=1795807786; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=;
        b=I5/wODJWDkk/WTn0vNmxyqVtCPSl4gO1A+GVQco9OAJdwKQkLqoHUnZNsESO5B2acp
         q2q1P2vGJ2Myin4zPLw2aRO8arTi7ErJHXWvyMzT9DlHa2znzbwgcbawPtigwsuX1+Q2
         3z3WSOBmuveqCf51BjY4TP5fo9DDCraHZBScG9tyZTNjlQ9pTVSxXfsSP9sgnxpftqPW
         ctBm3ogJ1Gdg+Drl5PHetamrOZ8NFeiIOSYVhG3eCc39udi6jex7r7oWhnYmWRjYTcd6
         UTYXJzYLMAzBCpp2u6fONh+wbzIQC08G70ZfjosrtFGRtVkLxp/qirchrUM7jQ/t/84P
         RArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202986; x=1795807786;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=;
        b=R2khf2F+adGWszi8dZsqxFdYgMRMqCgxuVNmnO6g8Q9r/iGoFy0uAcCELbQIzSIh7W
         euRziGDS1RFUykE/4Wa/mo17A0iGD/QQUps06N7p6QfpOCY1CXnruUUz4F5MvQsgjeya
         I8Y0Fhabsy27zD6tjAwIx6scRsJEjxltnABU89kRQoXzct82K80lHMbzz5u4MDBQVHd3
         P1NWoipxXARzqAnfzAMBgp/T8n+0X7RCtS6qfuaf2KGbFcnl5BAhm4wln1WLslKBzBkd
         IRs2yEbtIAQW0NopcIIlLizjPpaAs4Glrj4p+jUeErxTpNfScG42DeoZOItPA0FUcUeU
         u1wA==
X-Forwarded-Encrypted: i=1; AL+hErFsL3SqBJkcoyiEzC6cjMF1zlDmVXK5THDzpS38iVXzlF6dEizQ+jynKC9UCQFcV6wpDUWLbsYQsZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LT+72UZPR37/SxeVQlz82JZEDxGK1a++CnYAYqJ3Rcik9LOy/
	ijDepbseVV1BOynkzoipDk/GbiRGkktGC5ESD3dWtj9HC5TzFkmEATad/u3lPK7jpQ==
X-Gm-Gg: AZFdTZejzCJnf5cGKn7PMm9bRosuP9Vfce4rgXFj40elUsoJlVnmZYFE0T2seChCFSJ
	ZGVGlVDf1r1WU3+MbWzeCVt8gymTtpaG9+A30ebtgj0lFSrFM6XrxcYJlr2gVA9Ry3nkdtVCMp9
	N/l+r6G0nz8p8kiVAH6o9ExL2C2cNC4BC4+AIyqY9qMXubLxd5OHwiI4aTVKsy6VWn3Vb+YEqKz
	B/6WEvyImaRGmb2BdnnCPIHAk3Od9ai7rCrKKuwkJ7Gb25sntjH0VSjUeMi69ywvQC4KxUSdT7X
	EwP9n4BE9WuCpdRrnnQ+Iw8TkSLOV32DH1hgBbRIjJYpwR/WgKoYSsSSJDSHG7lnDTvne5p17/T
	LvXpKz9R6o3ubJV0NDHNpYxV9H6xgKz3kAkuijS1H45/D6pPUHcZZU++4t75qJo2lzHRJSvaxsU
	VxXJF2lahMoju1Ow7xY+c59SnDM+sZQDMIxspC5aTk2EvPNQUNb5ZfnqkdDqREUf84l0ZQrP2R6
	e+nThW4GaTuutf/lRU7I0Y12jl/kxjQeG3UzWaoD6bNuOtJczw52MA8paN0cKCEDwbRKg6w0SQd
	fjPATRDKslRntCeQ35oX7/dDm6/2wpzakN1J06uO4qL1eQRZQkO4PHr7H3jLDVwV
X-Received: by 2002:a17:902:ef49:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2f03f1cfb70mr39502795ad.20.1795202985149;
        Fri, 20 Nov 2026 11:29:45 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm18293005ad.16.2026.11.20.11.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:29:43 -0800 (PST)
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
Date: Fri, 20 Nov 2026 11:29:42 -0800
Message-Id: <DN0ACH1KR5BS.A33KFC1ZMPTZ@google.com>
To: "Pranjal Shrivastava" <praan@google.com>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma"
 <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi Liu"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
From: "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
 <awBkg0ODE436CZy0@google.com>
In-Reply-To: <awBkg0ODE436CZy0@google.com>

On Fri Nov 20, 2026 at 7:17 AM PST, Pranjal Shrivastava wrote:
> On Wed, Nov 18, 2026 at 10:37:00PM +0000, David Matlack wrote:
>> Adopt Access Control Services (ACS) controls on all incoming preserved
>> devices (endpoints and upstream bridges) during a Live Update.
>>=20
>> Adopting ACS controls avoids changing routing rules while memory
>> transactions are in flight from preserved devices. It also keeps IOMMU
>> groups from changing during or after Live Update.
>>=20
>> The adopted controls are recorded by the pci_save_state() call in
>> pci_bus_add_device(), which runs before drivers bind, so they are
>> reapplied by pci_restore_state() if the device is reset. Allocate the
>> ACS save buffer for incoming preserved devices even if they match a
>> device-specific ACS quirk, since their adopted controls live in the ACS
>> capability, and panic if it could not be allocated.
>>=20
>> To simplify ACS adoption, reject preserving any devices that require
>> quirks to enable ACS as those quirks would also have to take Live Update
>> into account. If such a quirk matches an incoming preserved device
>> anyway, e.g. because it was added in the new kernel, log a warning and
>> adopt the device's ACS controls regardless, rather than reprogram a
>> device in the path of a preserved device's memory transactions.
>>=20
>> Signed-off-by: David Matlack <dmatlack@google.com>
>> ---
>>  drivers/pci/liveupdate.c | 75 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/liveupdate.h | 16 +++++++++
>>  drivers/pci/pci.c        | 13 +++++--
>>  3 files changed, 102 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>> index 00d6fa5236e9..b99a88c2c199 100644
>> --- a/drivers/pci/liveupdate.c
>> +++ b/drivers/pci/liveupdate.c
>> @@ -123,6 +123,9 @@
>>   *
>>   *  * The device cannot be a Virtual Function (VF).
>>   *
>> + *  * The device cannot require device-specific quirks to enable Access
>> + *    Control Services (ACS).
>> + *=20
>
> [...]
>
>> +#include "liveupdate.h"
>>  #include "pci.h"
>> =20
>>  DEFINE_MUTEX(pci_slot_mutex);
>> @@ -1071,9 +1073,13 @@ static void pci_allocate_acs_save_buffer(struct p=
ci_dev *dev)
>>  	/*
>>  	 * Devices that rely on device-specific quirks to enable an ACS
>>  	 * equivalent keep that configuration outside of the ACS Control
>> -	 * register, so they are configured from scratch on restore.
>> +	 * register, so they are configured from scratch on restore. The
>> +	 * exception is devices preserved across a Live Update, which always
>> +	 * adopt the ACS controls established by the previous kernel and need
>> +	 * the buffer to keep them across resets.
>>  	 */
>> -	if (pci_need_dev_specific_enable_acs(dev))
>> +	if (pci_need_dev_specific_enable_acs(dev) &&
>> +	    !pci_liveupdate_was_incoming(dev))
>>  		return;
>> =20
>
> The ACS save buffer is forced for incoming devices that match an
> enable_acs quirk, but neither existing quirk keeps its controls where
> the generic code saves them (Intel PCH Root Ports have no ACS cap,=20
> SPT/UPT has the Control register at +8, not +6). Is the intent that=20
> such devices just lose their adopted controls if they ever lose config
> state later? (e.g. a Root Port D3 cycle after pci_liveupdate_finish())
> If so, maybe worth calling it out in a comment?

The previous kernel refuses to preserve any device that requires a
device-specific quirk to enable ACS, and every kernel that supports
preserving PCI devices already has the PCH and SPT/UPT quirks. So
neither of those quirks can match a device that was preserved by the
previous kernel.

A quirk can only match an incoming preserved device if it is new in the
current kernel (or the previous kernel was built without
CONFIG_PCI_QUIRKS). In that case the previous kernel did not apply the
quirk and programmed the device's standard ACS Control register, which
is what the save buffer captures. So the device just continues with its
non-quirked ACS configuration from the previous kernel.

I will expand the comment and the changelog in v12 to make that clearer:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci=
_dev *dev)
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
-	 * register, so they are configured from scratch on restore. The
-	 * exception is devices preserved across a Live Update, which always
-	 * adopt the ACS controls established by the previous kernel and need
-	 * the buffer to keep them across resets.
+	 * register, so they are configured from scratch on restore.
+	 *
+	 * The exception is devices preserved across a Live Update. The
+	 * previous kernel refuses to preserve devices that need such a quirk,
+	 * so a quirk can only match here if the previous kernel did not apply
+	 * it (e.g. the quirk is new in this kernel). The previous kernel then
+	 * programmed the standard ACS Control register, so save it to keep
+	 * the adopted controls across resets.
 	 */
 	if (pci_need_dev_specific_enable_acs(dev) &&
 	    !pci_liveupdate_was_incoming(dev))

>
> Apart from that:
>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
> Thanks,
> Praan

Thanks for the review!
