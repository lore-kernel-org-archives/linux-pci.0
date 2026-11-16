Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847951;
	b=wB02v4Sry+QblUtBdBkIW+PJ4hNnOB2dvMB2VizIC24jkngIT6tAj124QM73oE6muRIh
	 V93G9NftsyvfDg4K3ns1iFaIBHJDy2XtgTtL2ro1odCsCDeP4hvwho8pHYoFBnTSEppLJ
	 KVzO6gz3mB4wTcGnjRRwFftzlcJcVyvoQP4FSXy7OP/BtBMH50Yrbxl1YbLKez+vB476m
	 rZ1icOHuuqboqiuDHp3oUtYJLbGmfp+u23FsAzkqhbjUK95qYfuqOMgQcBTAQKOt01tEm
	 l9tUdHKcTB4HiC8h6Eb5K2c0EegxFmixUn9yw0wZxysXBEHRCUpR8Pj8S4LbNcbfzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847951;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:cc:Subject:Message-ID:MIME-Version:
	 Content-Type;
	bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
	b=A6fHl1M+qirGNZKcZ4xgC0x9kvZii99l2ZZmWPntQqYkAFSQN3zlckmZSFQkR+/H/MQm
	 Reg5R+V/yEyZSuGby4hnq0aOgaTzloUpw8+T1TDjwQiW2wEj+1zATmTNc8yqvC6VvL/Yu
	 OTEzqm2dfEORa++5sh33TD5ApZTkOKRb3Bpw3fEjuxyG7jxsvBWoh0WmXCkJQcyYhpMfo
	 Hop0R1FCm2Y55xBNMGsnjYovcIN4qUQjxnOpooJas6ptFGf8zcmvBFom67KCPgAyD+PNy
	 EW4mkj5bEnqHg3OexeaW4cun4LlcRz95Kc2tLuwYv9LTImDXsFapVWPJPlbCvDLwYEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLN2jdft;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9Bq3kgT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCA606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 16:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACCA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLN2jdft;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9Bq3kgT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
	b=RLN2jdftg+GXEkzmyyQp0gpHtNcHmpuHgzM3tuOg13ZgieNXnn4jYvehUsDeO9hXxiqsIY
	pJPKXJqzC9mCGIl8BxWME/gERImc696tb3dclcmx+jl+qO54OPjCuFMsjjonzdaVCqWrfc
	cEjMceTkiSL+kED4+cVWMn9HZxHvdSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-o5q1LNFAMQqt1toNdkrM_w-1; Mon, 16 Nov 2026 11:52:28 -0500
X-MC-Unique: o5q1LNFAMQqt1toNdkrM_w-1
X-Mimecast-MFC-AGG-ID: o5q1LNFAMQqt1toNdkrM_w_1794847947
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4901562b819so3508788f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794847947; x=1795452747; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
        b=Z9Bq3kgTw0DCa6pe676LPIqnNDt/9WjraZ8G8Xa+5UDdxR7RDHiETX7y0P0rXYvM/n
         H22ZSGbgsInFe4/12Hd67R4wKKFNrCCa9UwM5oQvzDLfDFD0uK6F8omJo+TGF12vrOMF
         g+p4oM4EE6sP9gtfCyRpjHU05O+sVCgFMUnGOng9wzueevjy0OYTfYd9gG60dq7OyDjs
         k1Ngq9rIYsvwDyzcVYH1N3NGwilFL6QEEjGkYeYcDgkwnS5I2gWfB1j7o8E/QdjKFTv9
         dWKqhBrlVlDGmmJws3Wt6VcJsljbwC29/kkRETWZC1mHZHfHczKk6NNMXyT7Abkp/Jsb
         Iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847947; x=1795452747;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
        b=Dq2J7PS5e25mJalCQDHZFe1WBqvUfIAhQZU/IRvfemSrA2PX7Tgs58Tgdf+vD8PDif
         1ra8WwGVED1eFdTCnB+/SxG236MG2WWC368PoovPvnVrbl8320/thsx+hK7+4J8UjNdH
         ddZ1SuvBCR/yRVEBp1oAXk2BIpuz3LiMKjnOv7nxhvafSnAtz0s4m+XoTaQY6KtkXauK
         FH1cY6mJsb+J5dlnsiwZPiygOCtDMpLZsrrmiebhs6x6ZE9W2UorRQPl80MXKHtdIYHU
         8vxWz73yaNTCb1WuR/fs1tLZKGxI1kY0PkuBAvDdxpfIigX6emi+ArtRaEKgYmlMoymV
         Q/pA==
X-Forwarded-Encrypted: i=1; AL+hErF92Az0cBudYkSyEJ7CtjWJA/MuCVJklPl2V7htfaUjUDeR1l0YGuvi8kJiz8BeCQkK1c5YOpXaDmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4uATm9KeqvBkZOPuJC4k0hIlt5J4YB2nkpcLaQb3avx5An7me
	d8Vckdj06gtaCf8vVl8EMIEFICEzJ1ifMUq/4kvcAyIz6BRGGSDVCwRs+LfOiXZvQ91lULoqF6y
	clP3YxXOZoF2EzJsYphqQMeGv6+dn37Nizna6lRRvw/2D4Etv1BM+lE+G68rz2Q==
X-Gm-Gg: AYBFou32Xw6gT0n1bD3WQlwzORrUfyj60ap5KSwt5t6HMYWMytWGDvxIm0LOI5Dq0iX
	My0EmRc+mryo+7V41DeuXpYN7xvZ0cGyZBLQrCUy9aJSt/sTE/2bmv/azySZqt4UvHfvT+bovz0
	WRHlRxUrNB0EyFjLOQVnJm+rb9AR9XCOsu1wPTjCt04zwaK8BNi6vp7k7ef9NesuhYB+B9GEO/K
	jIQF23mRbW6xB4oqvoy7T3dECRmUSa8qlWt0R2PSgYtGnIXE6CF0KN2Qxd0Be8z/Y6rHkpCwWEE
	ymZHTgn8lggwSTSd9KdG23M+fV8GZg5GpFW1cg6BQH/Muu32fvuz3x8sbRsbZsQvUExhn7ZISlo
	uKvyRqxiGdQFbIdg7VBjbjso5V8Gat0GIP50DCBHYJA9aqeGyFpLby+qYsLeDzocPI11iaAJS+X
	jN7Vadld95O2nzWvqkFWt3293xwCSAVHj1lmpSvw==
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr216665525e9.1.1794847946445;
        Mon, 16 Nov 2026 08:52:26 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr216665155e9.1.1794847946032;
        Mon, 16 Nov 2026 08:52:26 -0800 (PST)
Received: from seott-rh (p200300f6af3d8001f2fecaef96c12e29.dip0.t-ipconnect.de. [2003:f6:af3d:8001:f2fe:caef:96c1:2e29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783965d4sm1390415e9.7.2026.11.16.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:52:24 -0800 (PST)
Date: Mon, 16 Nov 2026 17:52:23 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Igor Mammedov <imammedo@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hej Folks,

using ACPI PCI hotplug with qemu on ARM for a device with a
BAR > 2M fails because of a resource allocation failure in the
guest kernel.

Without ACPI hotplug the same usecase works because the native
PCIe hotplug controller would increase the resource window of
the parent PCI bus.

X86 shows the same behavior but default resource window sizes
are different and qemu can use ACPI DSM #5 to hint the guest
to keep larger (predefined) resource windows.

Efforts to adapt that behavior in qemu on ARM failed [1]
because they've caused regressions elsewhere and maintainers
thought that Linux hotplug controller should be changed.

But this also has been tried before:
40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")

Unfortunately that led to regressions as well [2] and the patch was
reverted:
5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")

I've tried the reproducer mentioned in [2] using recent kernels for a
couple 1000 times and didn't ran into issues.

Could we give this patch another shot? Or does someone have another idea
on how to make ACPI PCI hotplug work with large BARs without breaking
something else.

[1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/ 
[2] https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/

Thanks,
Sebastian

