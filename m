Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617407;
	b=DlKov3cibzjU7Qh38aDNd9L+9UsizOTReVS3Y2h4XRetePbly+kMNWRRD7aRosxGU4jn
	 N0ur5W9DseIY7qAp01V8oD32djsIXg24pDoBgjJXMXF5vaHOFYAADgog0yjeChpJu1C/C
	 rsUCMQ4PwLP8HQrOn2HhHV8L3qdES476/CgnTjOp9S/rKvlnl8waARuOwNFzi3EkS+Ch/
	 x7GwcMspJUzep4Wo2ZiHzezKqr9x5JhzMBB1Jyh3cRaEeEG6qVZkl5poyzw3ztT8Ubo3U
	 2fY699Qeov1BWGt6+N2FHGs4tR8OG1i6IA6ImFEuiD/VXrfDYcQ3tEfXWiIWtfFxwbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
	b=ySlgLryaIzJAZCWkivwty0UHrBdUB8LxZAGugSiVDTDZYmtr1MFAsGdg4eqRmBLdppkH
	 O0A4IiLUx8DAZo2Pr7v41O46EQ5W3/PkJfUshrKvGWHTaTCH8oBMV1tEGFvFoboHU6QQN
	 PRCJGE5I0Z5qEJdZLKLaMtQaL+Q7CnmRAgblJE5Vg+YzFD4qhexrjUynsrEqhH+ogOYxx
	 vq2/v9ifk/2U2kK/vkHz4wRh52gZGhToxByuys+duj7+1YNbyTa4tOWK3BqSj5hfrMQam
	 S+4TMZlvjgMrCImtTzGFP/Vifh+chGtFCYI8ZJU1X2FkhCAHqP8hjvZUA+UnHKOXo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TBwymOjU;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1F606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C1F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TBwymOjU
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d2dcbb905so33243301cf.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795617405; x=1796222205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
        b=TBwymOjUH2EB8jnE/jzDjPScQd3It3v82RC2NRxhvs2i2+7K4UaSp8Xw3uCiWjtTGe
         kkImzk/0l3RKS35F/0uh5EVeq4b2dcQVw4KArqvJ33BGgJW4vi6F825+zw0MUPCOkvl/
         W2Jd34E2x0jQePn+vWk20Qw0hhq2Q8xLeMfwO6G3lvMay03YVrI7p1BpTJOlCxRHNv1U
         /n4dKrk+8omNEbO6MBdm8W41iKx+OVaH/j/OPmrGELVxP4Q7deOURL/4aXHHt1Rk/6SQ
         uc0ElLV3QXhdtmR5JdhJ/QjlyMhhFPc6RVwFDLFZzkYr+AQgyTNkdauIByHOgi9XlWQk
         CYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617405; x=1796222205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
        b=vOIdfAUzg29PhnCS3u5ay+xGutc8NLBB2tugLCgyEldRPS3UcZ8XLA6CAnk+y4G8/X
         F+31ytkI2ZMh4O8OaswT+OQq5gr3oWmnjZstaNEE0OQnL6pOCAt8/AarxYz4u7obCAUf
         7zmUqk+E8ikGpKImXcXUm6aGSP+7S4L10VwbXratJmuOhB5i82Dn6E7vP1LRXwoYvvoH
         fH4yi8kzT6BM7i/Yoq7vnbTgybyR2A0Q3GQRcgjTBGa13ogkWfrNScKQqnH5xz34z1i7
         gvqigbRkHsR/6yFTRH4kQO1MxPWvXrjh1gY8UrXXvSOVri1MkjCweEaVvSKLLjSzMr90
         nzQQ==
X-Forwarded-Encrypted: i=1; AL+hErGvXTwTX3ygoNgkn9YFyeLk3XYwZstpDHNixIyWqw20nt4Zifh3yBaYn8xUNlPcYmmEMDET37cwDaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C87Q6lHPB+CX89QiEYuc5WzBh1qir3oSu85M6K95EXPC/yHYc
	3Yxb9lwr2fiolXvzx9NaP563tDbJ8+iMlKS6sFqWOzwWwjoESihAKwmh3TUbqHKOptI=
X-Gm-Gg: AZFdTZfh23J9PK7DoXRBgCrfTjCGQF4Xnb73McKh/9iAL1mTqrDjzGQVYmjHzE9TTF/
	3cIGxNotrq3w71VfAutJwQEregM1/n+8BG1+o12WqwLZ1IWu3ogPsMHU0zZYZQNkCSi6lqLmUoe
	/sN8YO26ACd+Q+vUwQxASJNedMP30m8tCsUuZ+RF7FCHFpXfZrpIw81TQej7m/ncLv3lxZUw36g
	bZiMw8rKJlj6MSxKO5Phkho9hRM14e/Mo2LUvoKIsEJO5It61rYS4L3BCvKe939UERKpALEY+A1
	cNKT5TnqH5ekUsYCeRTJ95vW30g/CV1DJzstYcyn3tXh2DxobDiBNzkz1m2xs9vStk2zg1tPdG3
	W6qcNvmlPJkgtpJGhiukzrWAmhNR6nkk4d/fKR8OFH7nfI/+Vu1GkvC4gQh2gYXIrXY9Rfhb+j5
	BDeNsFgxLW2CJMSTyq5QTR1RS0SrDbxT/07eeLV3jC7G47xOT9FcEgUEiUIKfPQjd1/RPTWB1wO
	a2GOE6JiQr4vDz14WPWMCLBwq3VZb8uEzr8a1nq6X8et3F4ObZ0vxSyhra2KFWXqlivsPtqOof+
	2yIZyA==
X-Received: by 2002:ac8:5e53:0:b0:536:699d:9a22 with SMTP id d75a77b69052e-55d76aa8754mr328840131cf.57.1795617405368;
        Wed, 25 Nov 2026 06:36:45 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78880604sm157945401cf.24.2026.11.25.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:36:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWE72-00000001la3-15Li;
	Wed, 25 Nov 2026 10:36:44 -0400
Date: Wed, 25 Nov 2026 10:36:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH v1 05/10] PCI/TSM: Add association locking helpers for
 evidence acceptance
Message-ID: <20261125143644.GF246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
 <20261123153507.GH179082@ziepe.ca>
 <yq5ald6h9r1g.fsf@kernel.org>
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
In-Reply-To: <yq5ald6h9r1g.fsf@kernel.org>

On Wed, Nov 25, 2026 at 03:22:27PM +0530, Aneesh Kumar K.V wrote:

> > That cookie should be held in the attestation driver and when we get
> > to acceptance it should be presented to confirm that nothing has been
> > tampered with.
> 
> We already do something like this on lock, we track the cookie as part
> of CCA and use that during accept. Sure if every architecture supports
> this at firmware level we can abstract that to attestation layer. Yes
> and this protect from hostile host.

Every arch has some solution, but the critical part is the cookie must
be tied to and exposed into userspace.

start returns some cookie ID, and accept only works if that cookie is
still the current session.

Since we have a uAPI that allows multiple userspace threads to open
attestation this cookie prevents trouble if something else open/closes
the session from userspace.

Doing it transparently in the kernel isn't protective enough, IMHO.

> But this patch is about keeping pdev->tsm stable in the guest. We need a
> mechanism to associate a TSM with a pci_dev. Currently, the host uses
> sysfs 'connect', while the guest uses sysfs 'lock'. It is not clear that
> we were proposing to remove that mechanism.

Everything uses connect.

Once connected the attestation FD is created and its internal locking
and disassociation scheme will prevent any issues with TSM hot remove.
Basically when TSM is hot removed it unregisters attestation FD and it
is attestation subsystem's problem to lock that, not TSM.

Once the viommu is created then the ref mechanism you build prevents
TSM host remove while the viommu object exists.

Together these mechanisms should encompass the entire uAPI we see
right now, so we shouldn't have or need yet another layer of locking.

It is why these sysfs's are looking more and more troubled since they
are existing outside the natural object and locking model that is
emerging here.

> Are you suggesting that the TSM association remain under sysfs control,
> while IDE teardown and TDISP unlock become CTLV operations, and that
> sysfs disconnect or unlock be prevented until the above CTLV operations
> have completed?

That is roughly what I'm describing above, it should fall out
naturally from building attestation subsytems lifecycle model
correctly.

Jason
