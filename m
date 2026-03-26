Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0A33F370
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543015; cv=none; b=LU60G5EqicnVUBO8DXc8fhoQT7UPF4DqGkyRJVs+3ZqSLgnd5NwIFWoeKaNAMBU2TcSEl2Ch6pxR++MM2ySjkIXgffRpmQmmd/TdxApn3kXoStYh80xi34e0pYcUAoqTwEGIcxy2VP0yzIO2j6kRGQu59mWywufEsuT4woyAkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543015; c=relaxed/simple;
	bh=AJfO0MJr3HdxXPcf0hgHJTsN0WVxdNOK8YB/u1hEqI0=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=pBuVbKGsE1SGDbMzIW+u93oEXhUG8Bul2yqKuD9LCNvzEuzlXn05IdxHwVK3S4AVprDyaRl0lcQ2amXOXd2ETiUy0qk3JLjvIeepRMYez4s38Jn9cKBamg4/TE+7I7p9FLwy/rGMFZOKY9zqiEHiQ9qNW51a5BgpsMbHoOKxBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DbmqTbeI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DbmqTbeI"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c68b0763aso12989556d6.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774543012; x=1775147812; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AJfO0MJr3HdxXPcf0hgHJTsN0WVxdNOK8YB/u1hEqI0=;
        b=DbmqTbeIz0uheQiXaflGQpWhVY+v6Agk0cFrSphXfxSX8xi1PYtmtdxx9q8sILGVgB
         3KWqUIbMz5z1+kcIwj2WW15yla0sZeQ6kp8B+pIkrF/ZnDoa4b7Hx/wy2s2P2J9vOe9r
         ceOTT6viVQm99LrUzWYC1nigfVzAJc5iZi9aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543012; x=1775147812;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJfO0MJr3HdxXPcf0hgHJTsN0WVxdNOK8YB/u1hEqI0=;
        b=LEy5NGTF37XBGsdPJqk4etxMbI4wAvRbi+zXwS+ok6NP6hMgsZqJGm4doRZKBJj5R9
         Jj5OVgQH+dZV5XDQFKvHDUVLobGy87qQO1AcgJh4jNOFo1GsCahSo4od8SPGXmT+0ITD
         fXdcdbaYZ90xPbnydT75m2BbJDuwMU0Zc1fb/F0Q6AKRJFzOu3xJjataToPb3hieqFRL
         Oa1c6M6X4ITDaPQZJb5aMWO0hMtIKIyaWBIVDPUP95l4oar8g2IfDQ9uxzS8o6F/WnsL
         zPDtTMz/ww4F/Qety/enifXGO5MulEXs6oky67DdvJ47/VbLGby7B/uA6NMOumoX6cok
         bU2g==
X-Gm-Message-State: AOJu0YwOMvabbAuDQPZymGP9i7GUV5Ay0e7G7pDpGQmiF9geO+bNlY9C
	SQLxQINs0f+R6SfIXPtvkoUbvremeYBeb+4pWLgon+DAS4s4cP/HJnnMN3qggu7AzSwdd5KxQjO
	CJtdjcCvpXlXVLGpRuIuud0kwr+9rVmIpR4HtVaod93nMdifWhIB16baJ1dfH5V8b3kGELupmSs
	6ExX6TtG1UmCs70KRLAjYcoNhMlw1G1ME7sZDSVGU=
X-Gm-Gg: ATEYQzxqiGwNE5LnVYAOjPkiHgP11EeKVwGnM9YVi73/E0CAbKHz6se42AQhbzEHfDd
	DD4sQ0VTE088blgf8IPBu8hfkUdsMdSrv+mx6U4WL7hc6JDyDuXKPly6NEC6lJOI0j+pe2FYzpn
	EWhrqWrvtUQJQuMunTLrJGbpIOt1H/l1oWh9BJI9g6fjhigXb8QGOhNKqjkPZXIijuNayh+wQvq
	IqIM43wkkBtxmcB6oagQcOClwjXShloz+nRmIy9eC5IBPVchH+5cy/JY/bqfEwlWcbqlGoqgqIB
	M/uMyM0nyAPe7ZuwY0i45OfXYrKIE8pfzvclWQmeWtcG89hWsovJ34/8uwONZqZyq+xZKqNwzxk
	GdsNBbctg4TaN/hi+Yjr0vI5DVJkEaqAtfrXT2EqfJnW6E9yl2qIPFHxGWq8SzQR+9sPQ/ti/CF
	LPFtYBxixfzjH+DL3ZGZ4GcwDYLRMM1v/O7Q==
X-Received: by 2002:a05:6214:5705:b0:89c:610f:fb82 with SMTP id 6a1803df08f44-89cc4b35bcdmr113233066d6.63.1774543011485;
        Thu, 26 Mar 2026 09:36:51 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5857987sm30208886d6.2.2026.03.26.09.36.50
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:36:50 -0700 (PDT)
Message-ID: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
Subject: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: linux-pci@vger.kernel.org
Date: Thu, 26 Mar 2026 12:36:50 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[This has been previously posted on the linux-hotplug list, though it
has been suggested that I post it here as well.]

The short story is that ReBAR does not work in eGPU hotplug(!)
scenarios: hotplugged Thunderbolt eGPUs are forced onto a 256MB BAR
regardless of the system's ReBAR capabilities, and this because during
hotplug the Linux kernel does not consult the ReBAR capability. As
eGPUs are becoming more and more popular, accommodating eGPU hotplug
scenarios has become imperative.

The longer story:

The current Thunderbolt eGPU *hotplug* sequence of events is this: BAR
2's hardware register powers up at 256 MB =E2=80=94 the default size progra=
mmed
into the BAR's address decoder by Intel at the factory. The PCIe
Resizable BAR capability advertises support for up to 16 GB, but it's
passive =E2=80=94 software must explicitly exercise it. When a Thunderbolt =
eGPU
is hotplugged at runtime, the kernel's PCI subsystem enumerates the new
device, reads the BAR at its 256 MB default, sizes the bridge windows
to match, and assigns addresses =E2=80=94 all before any driver loads. The
ReBAR capability is never consulted(!) during this process.

A workaround is available for cold-plug scenarios only, and is
achieved by means of the **thunderbolt.host_reset=3D0** kernel parameter:
this preserves the BIOS's PCIe tunnel and BAR assignments from POST
(where the BIOS *does* exercise ReBAR). This delivers the full 16 GB
BAR but, as just mentioned, only works for cold-plug(!) scenarios =E2=80=94=
 if
the eGPU is power-cycled at runtime, the new tunnel gets the 256 MB
default.

The proper fix would be for the kernel's PCI hotplug resource
assignment to *first* check for ReBAR capability during enumeration,
resize the BAR to the largest supported size that fits within available
bridge headroom, and *then* commit bridge windows and assign addresses.
This is essentially what the BIOS does during POST. It hasn't been
implemented yet because eGPU-over-Thunderbolt-with-ReBAR is (was?) a
niche use case.

Seeing as eGPU-over-Thunderbolt is poised to become mainstream, this
can no longer be considered a niche use case.
