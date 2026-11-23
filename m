Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447660;
	b=j9BHKv+xh6sLij9qJZ3StHzbsEzJOgqR6ziAtMtVjtqwsBPZMPgcSZGu6X2KqqSUYjJY
	 xypKvQcbVf3osSVHtf6NqczkIzXyv6yaz0TmiGMvYy2DwZ9+2behpbOVdRjM0+nIxekFt
	 1CQSmHei7h5/6dutDjTJOy2UA5Tpgp4TTAGAIG7nw7PL925ciGc+t4m71B2xkybRHATak
	 GllPM8QEitoapKHiMU/lVv7ab8u72ukBNVLnogxXthlwQRQmtcNzeyZRv5SGi4LjJyZoM
	 Qdv59+2u21McDfw2cCO7jDOzqY2wdrraZhQTizjyn6UV1OqOo8QRMlcJEqDj38uY44Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
	b=C+5OU5EDt2fuB8y0GVjGgHZL41la1x7CQ8QWMxT2mmDba6aPnDj5p10bSzkRXrufhykZ
	 nw1W6F0/CvzzNKJz9LgkpLlsuAhR2MMD37OoFtugdWNfvWmPCkWL5TxPvvjX05ydUUz/3
	 tN/EP+2I1Z5Q2+nFRYb8WvAUoMJQh+1XJ0WHt4W2Fhdp/U3bflPaMbx1DtJZw3smd0r6W
	 UtxLGeyO0BKFTsbP269FoN2laH+otwhIaA5jR15EiEdIju3ESU5ofRxVeOnosouyl+Zl2
	 R6gEBoutvBsB7BSql26IUUJptCPfBwuXlt/J+FWflJw1Zo+PevkRUR55K+OVt/a+J8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="CUkDJ6/i";
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E3606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CUkDJ6/i
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d360ca878so31377601cf.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795447659; x=1796052459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
        b=CUkDJ6/iRI6Hw8aeXlh4lVJYEL8gjW9PUvkBPFPhkslWz5B9RS7X5yYMZPPyQ314vq
         +BIj3vtReJ0tZqB/w1ktkfuYIEF8QDXVuoA7XEEqYyBvchOOjc86mvy++NI+cBffNZjQ
         ejJCctA8xiX8JdgZi1RxnIVZmDbwMwzeVExs180iupqpAKi6NJWjQX2Zf8cqSnDS3sqf
         iu9mV5wmW0ysAAjeyMVLsoypnOKVKt1qEBizciKzVnSk8sOuJUTdc2psgpnS/8VLijtc
         qi1R573dFP4Rtq1ACj1X+7Z/J1ucsIwiPPTsDSwTdyopgIHZBHhcoyjLnoKpxAFsmx3M
         6q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447659; x=1796052459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWLsIhN+kxPGKJoMsbdqyApLe79fwWP1AaQIjJntY6g=;
        b=KaDjNNok+GDofgJqCOGoebDVKyLRolwusrpS5DwD4QZ7qlTYu+nZMO/gYHWP8cYb/G
         5hV2hkulnXSxH6VrtGUSkxwbJMyp6f6G1qS0+3pmfcts1YMtUl1d6aWm/RDT+0ke5p+V
         tW6PZDcSoyQE3dkXH/T/pSapoL7zfXbm9twXysLAL3nhumOeVUuTI7yrUiRJDe08ezAA
         siJttuSHJmjwbrFG7egOPN2ByaOWIDcVvmmONnuomQRt9gX4PZDVtswA6AQkoh9Jqkrx
         k9hi+RmqZvQsHQsjaEEjBuvFVViUYBFPoy22epaPEhYQlwIc5wZ8V8tSb4RvBJoAtqtD
         Lr5Q==
X-Forwarded-Encrypted: i=1; AL+hErGBQMnqn3yu9IvxBi8fV6nMaP/Q3cNc8pgb/FfwQ9IIp4+5NyjSw0/asr/lggoqZlAfrAdKnoyzPxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nYCpplpvozKcn0LnWulIvHtLJcbXNFyCpkh0YxVhqjbd6XNNo
	y7111deLyUUULZiiYze3acvaCXl9in/4Pt+OlY2ultqbQpfYAkPWMdMHuRTbxM5U6/s=
X-Gm-Gg: AZFdTZdtX+QNM9wIC9JK8RnQHBEsyvSOsxdlXtBdZo0WVou8kLVwtd1SpVvyPDzS2Ar
	bBMg//WOhwa0oXP/3fBwqkBYuIum3xZbxvWHjgARP9wr7rHAPECTh6Tf7corLIjFVxfDR406M1y
	8hjBTrsxWydVn5wMzdlrVXsaMHnZQ0fjVTEXbNaHXRidor3ySszuB1kX529yzABSaZEs1zCiOu5
	KcPewqsG48imKf8Q64gnZyh+pgAMxXtC9B93uVaYe5WCVKqt1k++j57FbX5J0lJN9hTme3RWHkl
	Hbwx33mRrumXqUOkGEYx3zJjNmLot6Ancjqxcbv9hEvrxYSSVBuVClLkP97uh9hkQCa6sYvWkX5
	hmfCHsHjCie116cm2MJSgJVgCEvVW5DKLOBc6VaN/SNvJ+UKc5sJdLv59MXLu2WYwDPLo1GYrsH
	75EQfkp66nMA/0TWeWbtj3zAIyR1wkB2+1yv2liwleFJ/MqGct6WMo5ql6QO2IAADdH4F1Z7gfk
	TMhSvz7jiljzXBsNtTZo1WuZRSaPafqh0DQC9uCaSRy/+YtfX86WvlMY+ha040A8TqYrUE8zhGu
	9BsS8uENvA26RwJpCdDthawEZ/oJnj1Z3343r1kQkbw4bCskQDVG5GXD1GYvnLeixVinVBxSWfr
	ZUhs=
X-Received: by 2002:a05:622a:1a8e:b0:535:2794:851c with SMTP id d75a77b69052e-55d76ac54famr221466701cf.39.1795447659366;
        Mon, 23 Nov 2026 07:27:39 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882bf70sm102842001cf.11.2026.11.23.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:27:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVxC-00000000sQR-1ESr;
	Mon, 23 Nov 2026 11:27:38 -0400
Date: Mon, 23 Nov 2026 11:27:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 08/10] PCI/TSM: Add sysfs lock and unlock for
 guest-assigned devices
Message-ID: <20261123152738.GF179082@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-9-aneesh.kumar@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123083337.2731019-9-aneesh.kumar@kernel.org>

On Mon, Nov 23, 2026 at 02:03:35PM +0530, Aneesh Kumar K.V (Arm) wrote:
> A confidential guest needs to lock a PCI device before collecting and
> verifying evidence about it. Userspace also needs a way to unlock the
> device after use or when verification fails.
> 
> Add tsm/lock and tsm/unlock sysfs attributes for TSM drivers
> implementing devsec_ops. Writing a TSM device name to tsm/lock calls its
> lock callback. Unlock calls the matching driver's unlock callback

I thought we agreed not to do this in sysfs as we worked through the
SPDM stuff?

LOCKED should be the 'start SPDM' action in the guest
RUN should be the 'accept SPDM' action in the guest

And though we didn't talk about it there is likely some 'destroy SPDM'
action that is UNLOCK and UNRUN.

Jason
