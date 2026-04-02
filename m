Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2906382390
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125754; cv=none; b=UtmWcRUWU/baVotM0W8LnvhQl9ffd8S5a0c/8v8QaAmdThTNadkeq757nNkVZ4FboLTNUC3lnWvq521I2ezj86VUMHsUuxlclHmyJdbfRXrFsZmjCB15xE3Z2kiCETYz5AqYtOOOHOYT4zQENfbjOKYAPh7iNPI8hAJhENO/EZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125754; c=relaxed/simple;
	bh=IW1lOPDfzNo6iyC+RTfQZKz7s0OSLg8gYMFYo/QQozk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+g1sttA4Uix7K5pAFjYb/60BifZF4I9+DBP4WM7CzrlaPveTB9EUD+rhjg2IrNTlTGumfpn5bCuY1QxhoyKAmiSCL8lcB1ZhIsuxirtACZqdnUS0shT+MSeCdr3g7UuXg+dzGO8EZ/naaVvjOleKRlW6LfcNP44HyVlPJNBzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hkrfya3A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7p58Ar1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkrfya3A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7p58Ar1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775125751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
	b=Hkrfya3AsuV4FIAhrIdE1gh/476Ix3GB1xnpLmKXdZgi8A96CJyejyMsXJnSFhGSdhSXeN
	8R2aUs3oYx8IgT8EH3BLjHQ3fVuKVbeC8RCxWPTVNisc15UKfnqErLnMaLqfI4zti+3NQP
	9hMc15tV8IvvKWBdnKt+cni9OnHvthc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-oSobPug7MeGcgLDVC9n4hA-1; Thu, 02 Apr 2026 06:29:10 -0400
X-MC-Unique: oSobPug7MeGcgLDVC9n4hA-1
X-Mimecast-MFC-AGG-ID: oSobPug7MeGcgLDVC9n4hA_1775125750
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b9b8e3af6so628233f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775125749; x=1775730549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
        b=A7p58Ar1DL/9I3ktXWNzHczcrXqYTd9XdCFVZlNNYm+xkot//ajZxllbCYpyOGvJy5
         g+aOBRcBa5N+PbUNE+y7GrPkvMmdB5IfFKuCq3T8ZdZbcnuLXsUBIhhEtpCNPPw1CbJX
         Uzx6mavsMi+d+bWH/QfOzHOoaa8sxbcDrGzUCu0vI3A51xhLHdCfz9bYGR881mn6qk7x
         gcLq/OjhWA03FpSrHq+PG5D7fLvjeTkB78V713/2W4QCPeMITT2B8NUWQxuYHK5eCqLp
         05ISewfbCwAablWhFf3xSpzJ6kU6pX4wJP4MvnV/ajiV+TYDUC20BfXGuSkNr/29Ht8j
         HA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125749; x=1775730549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
        b=NoHP16vIj23o12VBi/w8OSPjjA9Kf9pMj2a37iF8/mIbcZdQuzU9Pe3M5xkQvKyRCS
         0aK2CWzg0q+vza7yQMofn1XhVaJKdSWBQ65UuM2A67cUHzra5HNaUDsDedf5DwblC8Ay
         2TQ+kj+kLT8UHZkGIKmTT/Yh4vvZpxZUPDmjqcIf/v6VtXjt7soSaWtC6wrEyVV7XoNy
         mR0oOSiS54+CGh8xfZo0tLyB0yfEazi2EflfgXSrEcJugQarp7eUhXT9k6TF++wV69T0
         obVTXoFOzUZpEi9eE1hILdahGUa1NrnSCgojwa0Dfh3JEdnqCaZaoime5WjgxzT6K0DN
         nB1g==
X-Forwarded-Encrypted: i=1; AJvYcCU3SJFv27UCITZuH1N+tKL+vI2hQJXBCndnW+L2LNooqIawQVPJLMIqw7UYrE5BtFGvsXV1ikfkWcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPy8TfGowmgze9zqleMil+kgb6MWak8un9bathF0U8BYejEFgW
	DMAyZnFDKyuGC4Q5Cr/dtQDVjEjtiHKEvCvKT53f6x68uoDAu1fQQg6s5ZipLcBBbUi7HmFXKhZ
	4/cqOlvyea3Nf3OYt/xjWv9UKSKEO/ZVR6sQUYy1iD/O+f0Sz3W89qYoiaXd1kQj7dEE3mA==
X-Gm-Gg: AeBDievPY5AcHsbbfz/dhW3J96tEQaGaz8Tm38ZOrbdHefXI6ezcKIjN6ANPRV9swo3
	MSlNGstxU3axMKloxkVu1LOt1pug2yriPweRfFhXPlFSuFYMiaYiwDd6rV9G6DGxT63oeDdKAHy
	v+CicafaXz6sLdZ0WwaZMPN0tUossbm9S//1uxW177kC2xu0DdyrfLzCP64ZUNtXmdPHHUEv+oN
	j+UCAV8qHGi+WXgy8tZhMBjt9tzK3QdwuEvNdrmBHjLWBKnVTeUMxswpR72c4ZXvsuWgY6Sb9ol
	sJz89N57Os3YzduSNOPk/+eW5Wwvw8c3UJc4E2ezMWQ1YOjfOp4M5kLJdrIPLZsSiF8eFrddZv1
	jJ45JivsLW5nSRcmaWVmad+jg9ksGj9G+6udGcn/BszfDFYfnGS/dMMqWCw==
X-Received: by 2002:a05:6000:2c06:b0:43c:f5c6:49bf with SMTP id ffacd0b85a97d-43d1504985cmr12930725f8f.5.1775125749345;
        Thu, 02 Apr 2026 03:29:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:43c:f5c6:49bf with SMTP id ffacd0b85a97d-43d1504985cmr12930682f8f.5.1775125748892;
        Thu, 02 Apr 2026 03:29:08 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm6658714f8f.37.2026.04.02.03.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:29:08 -0700 (PDT)
Message-ID: <9f169800-12f2-4f98-ab99-e4433b2b49a9@redhat.com>
Date: Thu, 2 Apr 2026 12:29:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with rtnl
 locked
To: Bjorn Helgaas <helgaas@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
 dima.ruinskiy@intel.com, mbloch@nvidia.com, leon@kernel.org,
 linux-pci@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 lukas@wunner.de, bhelgaas@google.com, richardcochran@gmail.com,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Avigail Dahan <avigailx.dahan@intel.com>
References: <20260331173728.GA146742@bhelgaas>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260331173728.GA146742@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 7:37 PM, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2026 at 04:02:30PM -0700, Tony Nguyen wrote:
>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> When runtime resuming igc we get:
>>
>>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>>
>> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
>> linking as "ops protected"") added check for this. For this reason drop
>> the special case for runtime PM from __igc_resume(). This makes it take
>> rtnl lock unconditionally.
> 
> Taking the rtnl lock unconditionally certainly makes the code nicer,
> but the commit log only mentions the "avoid the warning" benefit, not
> the actual reason this is safe to do.

Sashiko says it's not safe:

---
Can this regression cause a self-deadlock when a runtime resume is
triggered from paths that already hold the rtnl lock?
If the network interface is logically up but the link is disconnected,
igc_runtime_idle() allows the device to enter runtime suspend. When a
user queries the device using ethtool, the networking core acquires
rtnl_lock() and then calls pm_runtime_get_sync() to ensure the hardware
is awake.
This synchronously executes the driver's runtime resume callback, which
calls __igc_resume(). Because netif_running(netdev) is true, the
modified __igc_resume() unconditionally attempts to acquire rtnl_lock().
Since the executing thread already holds this non-recursive mutex, it
appears the system would self-deadlock, hanging the network stack.
---

/P

