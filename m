Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133779;
	b=ohjIg5SPx+1n/RzMYI42uBjCnhQmIyk6qMvK/hKKCXmyBiyP2xMxH/Y1+9nXv81NMZxJ
	 EXBmb4fH0WR/mZbquc5we6uexBhRs7sIBhT2Lky0nMurSChntucR1V4IwbdMUlddNkiQa
	 T146k4DMXgfcpdbaxbZEEftTD2WeMOGrwLPr0MA9mPmQByXdx9hI9Jn0cTeh2hPCFG2D4
	 vulXoYqm9EWMA5ZzszfLDp+JmgdQ0Uk98JQqCDz0CZCrRUOXFIJPgRbf+ybtRdTf+AYRr
	 Q+uTkAWZNmXuKpluxU0eGeFM7mU9vAdX2W1BevJmbIMaFC8Jjx2kK29PKEPZ4XMNHvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
	b=gbDtPc+JlmfQqb96PwcdEokgrnJ+mHqHfJ3L2fVDR3jiwjU2pD5768K2LMIiw9XOMdWW
	 aV8lJc7q+bJpBWyp9g8xaAc+vjUbgbAQhTzME56qOt08bCp0OkHVzBZ2F9CfoQLfhKqOB
	 pZRPsVovfyO8AY44SYT30miqNrcwubJpSPEloA1H9V1i3e+TnFWDooBv9ae1tsAtxqJcf
	 Up3gDpY8W3jOw7vH2ZpLQCiZd+cUO4ekNIHYtcV1Y7Gt03HdOMCL/FtdiV794G8Fg6Amp
	 RjJLKyjM3W1zBUskoDSt0YMB+vRzSIvXj/XfcNGrU6Sh1ZKXoMfcHQius5gCfdIvegw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGxaXrD3;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B8606A32A
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8B8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YGxaXrD3
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f03920c4a0so1939185ad.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133779; x=1795738579; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=YGxaXrD3nt6EPnZPTmgF4t/3KSyiOMN1+lC4rUXlqKhSSkNgz7z3Tw9defhg0JcLNz
         COBTxMkEo40/X8sRQdM7HVlPc4YBUI3BOWpsLwV/c+feWkZ+jerXEi5k9B1v4Aj35evN
         34MBgyEFqjzAAK+aE+r1l25v875SuA/dwjm66qDtp7iDEdwiA0p+BZ+mvYZYV55F1oPc
         ytJ6fNB2IkjgjHg7MtQPV87reMTxS9vehx9xnwzlWqfUjqDj2DcuXCbR7QemVG8EjrOl
         ViWGN5eNUOfh7oLjeYPYCv+//QPNGWVPjeqJ8hnRLVjPVuR1qlAszE5eQcyfvgAzj7Jn
         sP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133779; x=1795738579;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=YqThfQuHCHWMS8JEMFNf/LV6iQzRy0i64QOiV3tMidBL3qFY/LI+a8VaOMjq4Vcc3e
         g8saTfYtf6Pwv1cKP5X453mA21+EC2LZEBVuzfeuE617ilLcsCsdzhm5OKMgbzeboMCz
         YrSgYXAlRvfiETn3LqgWs/9W09i2MnnggBd4nb5V7JWBecxBdRL5mBHb3yk9SoIWyO33
         a9CnXsn3r1vcw3vXvn/tug1A8Eej8tIhUC+FefHB1Kd1s94Ij5vW2A0hHFRUF8/L/pAt
         O0djcw4Fap3STNwTjUB58J3KkBzIzLPwH9wRf4aIiGeTUxuyeUNhvCYru1ihGs/dQtdb
         GhLA==
X-Forwarded-Encrypted: i=1; AL+hErHZOcknMH+fVoRGi+skD6dtzWCqPRs3Rxu9qgVyj3C27YB7txFPqvAAPTUfrp9djBmT0ePBEX0Zid8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vkFbdjDjlUs1rC7b/H7W/PqgbD0U8mA8Jc3O/S0kktlPp73Ib
	AL9otZjcV5SDqUqGyrBHiwAz5v+C6/yRxhjBuDWdEX4FUYM1dGEouZ2v2X2h4BUyvQ==
X-Gm-Gg: AZFdTZe4rgk3RBgInDoBCpei7/X7PW6oK8PBOsBQY2H8d6S2QPCzZr8dy4nU9LBc5fv
	fXXqryXLaGgJz1iTinlt7yTva7N4uFlrX5LTiijeJaAyw2Y74aL6QX2VxxKK3Qn2WySDSQR5UI/
	dKnoxUKUilYkg+fVwqUiso2oYvofYjGeqmxLS02BDfkMVZcckZm395zcIgNp89tg5qVoL4JBPtS
	hQfPb12S/80aWx1tA5k0S3wHtyqfxbiXqtbH0eUGxCj5q36kxqr6Dd7EKzkJg/96yyTlt2F4BSI
	UmqwyFzPilYWyJF1eSE14uJh2UVp+xhqbs+HIzZXqJSa5i7Ur0JQf3HeS+MKX69MjrVS7o0xlmc
	lKcZRWKKdw/L6GWPleSxZkQktalGueRYf6YexcUYxgPty2OWk+f+2J7bRmvR9M/V4YhZ5sYIAqE
	Cw+6w6M9UTbEJ02sBNKwGU9c1d5qbg4NrD+ZWX+RzDf8W3IBXVlqUDMd0gv0iMbmndPZQ0Rhmad
	/VscNdE8SnspQ57u9Gx4vGpKxA/4U5KNLT3WMnCUHp17+oUznziSA6fypc48+Ao8PKOYBmuawzQ
	2aaOXvSu3zbnzvCTwB6nIwyy2F7mosAkCOBc4U9hRvYUYbhraJe2596mP76j/Xqm
X-Received: by 2002:a17:903:2b0f:b0:2e2:dfb8:818a with SMTP id d9443c01a7336-2f03f20f8c5mr14954585ad.62.1795133778058;
        Thu, 19 Nov 2026 16:16:18 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm6072095ad.13.2026.11.19.16.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:16:17 -0800 (PST)
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
Date: Thu, 19 Nov 2026 16:16:16 -0800
Message-Id: <DMZLTC9U6DBX.3FR19X5M2IT3W@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
 <20261118065653.GE2250529.vipinsh@google.com>
In-Reply-To: <20261118065653.GE2250529.vipinsh@google.com>

On Tue Nov 17, 2026 at 11:51 PM PST, Vipin Sharma wrote:
> On Fri, Nov 06, 2026 at 05:19:28PM +0000, David Matlack wrote:
>> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
>> >  * Open and return an anonymous VFIO cdev file via
>> >    vfio_device_liveupdate_cdev_open().
>>=20
>> Here's an idea for how the device file could be created on retrieve,
>> which I'd like to hear your thoughts on.
>>=20
>> The patches from Pasha at [1] lets userspace pass a
>> file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
>> next version of the tmpfs series, I'm planning to use that to have
>> userspace create the file and pass it in the argument, and the kernel
>> then restores the preserved file into it.
>>=20
>> I wonder if VFIO should work the same way, e.g.:
>>=20
>>   struct liveupdate_vfio_retrieve_arg {
>>           __u32 size;
>>           __s32 fd;
>>   };
>>=20
>> Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
>> the fd. retrieve() would check that it's an unbound vfio-pci cdev file
>> for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
>> attach the incoming state to that file, and LUO would track that file
>> as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
>> device as it does now. Since VFIO preservation is new, the argument
>> could simply be required.
>>
>> What do you think?
>
> Overall, I agree with the strategy. I think VFIO cdev retrieval should
> happen as the flow you mentioned above. I want to hightlight two things:
>
> 1. This will lead to lot of code changes happening in vfio core. This
>    means VFIO PCI live update code change will spill in vfio core.
>    Should I create a config VFIO_LIVEUPDATE for VFIO core code. It will
>    not be visible menuconfig option but selected when
>    VFIO_PCI_LIVEUPDATE is enabled.
> 2. List of other inflight series that this series will depend on is
>    increasing. It will be 3 (reset function, pci saved state, and
>    restore into fd).
>
> For '2', should I send v7 without changes you are recommending in this
> patch and future version of this series can transition to the approach
> you are suggesting after LUO changes are landed. VFIO liveupdate series
> will go through more iterations, so we will have opportunity to make the
> change. WDYT?

Sounds good. I am not 100% convinced yet we should switch to a
retrieve-into approach. But let's keep discussing it VFIO and IOMMUFD.
