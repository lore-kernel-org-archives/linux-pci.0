Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831496;
	b=Z9+UBn+il8S7zccMn/10RG82F42YNno1Hnm08pdhmH2oHDTAoX7q7WdbzJHuVi6g7qgM
	 YOPQSmIo50Wzt4UZPY3xkxW6jbecDEvA8qYF97gZ6+nSyA5kuzwMx0sQAUm6/rXEY1bQq
	 BMb4OKTjMrWq73MBZvISJnYgrMrSHSBrVCkn2rv1vI9GXrrYtrbh6b4z7zZnfHkAebpwZ
	 RrmGNqH8CszA37eG8i1IicAAMzzJeCx8T1u8bY22EsmsxlAfi8VGguKUhbfnnsgxX7/LP
	 YsbOIjde15cVkW0pjRO2V+jClz5cnZZKQiRlvAkk3aHPtaJ5JNjsTWUMP7V22tTDL5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831496;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=MZnXXpRaX5wnFhQSXy8ctwKJuiJVzoVjhA01PjRQj/M=;
	b=Dszrfk75mE0bskYmmmxkCkHlieS8V38jYh0GTHA8TCFJ8heZevNlI76cOtrhvvNAIwgU
	 6buyaei/O7GHUavPMJGXIvgLWvR+425wyyEOh/sO5OHPpdNalNqCkCp2PlqGdk736h8/e
	 tSya2Okj+MpybsVZZltPhNxSXLn8bdXzmsp0l3k5vhAvh6uIPAxLwEuHQrpNilqVTwVv3
	 ifW/o/4eVw53zMkWtjkxF98Gobcqn6WHiOFt9HeaBpbPJIRz75MQsuRr7DpQrLldzZVgr
	 t5/3eYtGEdVifTHOAUDMhAILK3P4qcOCQVEqAJkXC2Ut3GbXeP7ycr86uT00MaFXk3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NJtnUumq;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF6606B39E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 22:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EF6606B39E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=NJtnUumq
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso920586a91.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 14:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831496; x=1794436296;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZnXXpRaX5wnFhQSXy8ctwKJuiJVzoVjhA01PjRQj/M=;
        b=UKOzvQY7lpS/fABBK3e4qLfBAm6sb35a4uz+NRcq5k9ANsn6CbMjTvA/dBw9SwyAiz
         OfldPLSEwZdpixnN69k2fdCTW/Sdx93T8Imhqdb+2FK+ulFktxs0WgHBjVH3uuUPjLJ6
         ypOwXiOTMHaqh+0zOmFAQsDeRoKh4AJohHOMlTyxuN1PHeHdcfTX5b8K0lnSy/DQr4fn
         AXZ+vir8oQKv9GYCvnNBLTlpzOdyJ+My+iEwZ96idRCAVJb1UzQs/bMzD41XRX+6TDkw
         D8pV94gJZU2cjHSC70EcmWcPPTlVgXHpqvl58e7vfE7nd0Uk/eWznRRGUR8aZIuAZA4z
         LaUA==
X-Forwarded-Encrypted: i=1; AKwUvBztuhEMkJXf0U0hCwvWH/vRCq/Jo6AtJ7yLDrgqX4mUvIyB/EbiwhHFiSwSP96eiimfaYdbgdeP2bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cf+gF2xTVNtunecDiYZwE/Sl/XuY38j3XhAp68EryXpWK/FzY
	5r5ylixX+i0Su4F9ORR+H+fG7BtPgC+DemHJLw5bm3lrGiDTVx2QuYAlor3dtN96JKuhK4g5gm5
	3V+beGq8uzDRC97C6gb6czvoASgncGOk/5QNWT0l5osd1rjxtBV8ueqOXFpe26rsE0L62Vo48u7
	5KTiaKqsdsNNIPzBUjUS97ZJXcydiAB8Wfpg0vjP1XTzSuvhqgIhj7Cua/4S4EdEJMtWBKZe1qU
	bbfgDnjM0Y=
X-Gm-Gg: AYBFou2pOhX0meMthEsrKa8tCzuHssA5dyCDC8M7DLWgJ9T2IV3fz8Xx2PyLZRoIcCJ
	LoD1QjGpGTfMesa0iI4WsPpjFzPVabWoV52iG/wly2goHCP8xMSUODJh7SyGWAgKgWCGmJEp0qL
	iIAtx0STywZQ/PUix/hu7wYkx7hmH8Q1Kqa0iAIL8ZcVpWTmcNLGKGJY+vRKDD15efdcF+36Fd9
	np+ZINfCo++s5LIDnPKXP1EgZX7DEYk8DwYja56WF1P0YFRuMR9swrXzzC65hJNwEvRqVJc7liM
	f1R5UtJQEecCMZpZdWFfWt/Dxih1FUBH1UhucOPYkIq8G/8Fz91y5MrqYP6ZhlS3fHttobp8/3d
	oERIA6rU6RShrSGfmPOCo4O+tcR0nDAIkfSWKKw2hloUm3lr3qiFvWCYNHLKAU9rgJg5kJnGQOm
	k1v3ifVfoH/rBxWk1yuf73Hol5AB8v
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3ae897f8c6fmr13151552a91.30.1793831495664;
        Wed, 04 Nov 2026 14:31:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b31cd728sm443027a91.5.2026.11.04.14.31.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:31:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c817b56adso24370626d6.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793831494; x=1794436294; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZnXXpRaX5wnFhQSXy8ctwKJuiJVzoVjhA01PjRQj/M=;
        b=NJtnUumqGCPu6ZZcSBf0JA+SSpBNTSgu2OrRWHphK7+kUceOkYqprm2EShvRQnzCsX
         c1TnUH+Lg86oNkb5HW8N0sD+UPhq6kEn4043gdrX6JCQDlA+ak3iLVganvlJ533JW8Cz
         i3VcBnrr3lzqiIDWhqnoFCZ8M8OAj5nglosbE=
X-Forwarded-Encrypted: i=1; AKwUvByCEsfhP/duIaBRWOHh5Xgr4s7lm4f08QUmqaZBJ/cUHJWXIywNvOagROhVntZGzNKFH0GqL81x9to=@vger.kernel.org
X-Received: by 2002:a05:6214:19e5:b0:91c:8632:691f with SMTP id 6a1803df08f44-91ca4b935d9mr282132416d6.51.1793831494462;
        Wed, 04 Nov 2026 14:31:34 -0800 (PST)
X-Received: by 2002:a05:6214:19e5:b0:91c:8632:691f with SMTP id
 6a1803df08f44-91ca4b935d9mr282132046d6.51.1793831494026; Wed, 04 Nov 2026
 14:31:34 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016182124.GA1884550@bhelgaas> <309f6f13-b010-4818-936d-4b7b4b389239@kernel.org>
 <179338093960.40615.2809022600772649565.b4-reply@b4> <de273977-8e8d-410e-8424-e99a0b4080b7@kernel.org>
In-Reply-To: <de273977-8e8d-410e-8424-e99a0b4080b7@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
Date: Wed, 4 Nov 2026 15:31:21 -0700
X-Gm-Features: AclHuK_DPry0maLO2zF5RJdfKHbaIbL4FCH0Yin17sY4r60u8x52Y7l_Zz2jURM
Message-ID: <CAJ8Y1dQBr_TmqC4=8ciLdcyO5EC85KYZLo6om7WR5cX-iG0wPw@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
To: Eugen Hristev <ehristev@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000a7ac8065f7af14b"

--0000000000000a7ac8065f7af14b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eugen,

Can you please also add a Fixes tag in v2, given that this issue can
cause a RCU stall in corner cases?

Thanks,

Ray

On Wed, Nov 4, 2026 at 12:58=E2=80=AFPM 'Eugen Hristev' via
BCM-KERNEL-FEEDBACK-LIST,PDL
<bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
>
> On 10/30/26 19:22, Manivannan Sadhasivam wrote:
> > On 2026-10-16 23:10 +0300, Eugen Hristev wrote:
> >> On 10/16/26 21:21, Bjorn Helgaas wrote:
> >>> On Fri, Oct 16, 2026 at 03:18:53PM +0300, Eugen Hristev wrote:
> >>>> Limit each iProc MSI parent IRQ to 16 event-queue entries.
> >>>>
> >>>> A continuously fed queue could otherwise keep the chained handler ru=
nning
> >>>> and starve other work. The budget still drains pending events and le=
ts the
> >>>> next parent interrupt continue processing, improving fairness and bo=
unding
> >>>> interrupt-handler latency.
> >>>>
> >>>> Without this starvation avoidance, one CPU can stall indefinitely
> >>>> in the loop and not serve other interrupts, timers, etc.
> >>>>
> >>>> While testing it with an Ethernet NIC,  when too many MSI interrupts
> >>>> come in, CPU might get starved:
> >>>>
> >>>> Connecting to host 192.168.30.1, port 5201
> >>>> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5=
201
> >>>> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> >>>> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBy=
tes
> >>>> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBy=
tes
> >>>> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KByte=
s
> >>>> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >>>> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=3D28ac/1/0x40000=
00000000002 softirq=3D28922/28930 fqs=3D1
> >>>> [  177.569457] rcu:     (detected by 1, t=3D5256 jiffies, g=3D21629,=
 q=3D819 ncpus=3D4)
> >>>> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
> >>>>
> >>>> With this bounded approach, IRQ handler will complete and continue
> >>>> to serve MSI events on the next handler invocation.
> >>>
> >>> Is there something unique about iproc that makes this an issue, or do
> >>> we need to worry about this in every MSI interrupt handler?
> >>>
> >> This is not specific to iPROC, so in theory it can happen to any other
> >> MSI interrupt handler. If the handler has no way to break the loop, an=
d
> >> the condition that generates the MSI IRQ happens continuously, the sam=
e
> >> situation will happen.
> >
> >> Some other drivers e.g. take the IRQ state into a local variable, do t=
he
> >> task, clear it up, and don't care to read it again, like the iPROC is
> >> doing, unless another MSI fires.
> >>
> >
> > You should rework the iproc handler to read head and tail outside of th=
e loop
> > and handle the recorded events inside the loop. This will avoid using a=
ny
> > arbitrary max event limit and allow other handlers to also run.
>
> Hi Mani,
>
> Thanks for the feedback, I changed it as you said, sent a v2.
>
> Eugen>
> > - Mani
> >
>

--0000000000000a7ac8065f7af14b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Kea1UXiDNimY9XcISXAUrVauS3TPqfSofCP4tOVkOfR2zFsciCJ7DPbmanfMXAR2cY6kCgkZCqxY
9Szy6beT2XZUSE9/jFymRSjXZNnLqAe30YCaVeVQUqW9X3NqlPdzO9Ce8AqKdgBlVt4isO6s3zJ5
djaWSUM3zrweXgaVpSRF3iBUxK45Nb0qOkvz0hrBYM2r+iLWR2YbF+Z7W7lw2QMvkbeT1gXn+4pC
K8f1aWKsB9e6Id7uBOkCAwEAAaOCAdgwggHUMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUD
AzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
b2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwHwYDVR0RBBgwFoEUcmF5Lmp1aUBi
cm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt
26AjhRiwoJIwHQYDVR0OBBYEFLfOZFpVhKW7s+LOyKdJX5PQH0f8MA0GCSqGSIb3DQEBCwUAA4IC
AQB5Y3tHNG503cqE6g1lZJG3Z1SbuQD8ZXUbYqDNZCnUAd/+zUCraK7TYIOI83X+oof/CscTxVhf
5mazzhESPjHYlC3TLkkxDHQZi06GwKbI00651REpC78vd9dOdZnKnGjpFeDiwJKNxdarSaYiZi/t
6cZD3FIvDaJwYIQ+8HvZOm7FBicC41sMoaxGWZ/tdC6yRoLFckWRvhq0e7wyaBOH2ae8l30V6NXB
RtJd4XemoNk74ybCcGMro0zyBCzQhREo2slK5r/uflroC607XCCIGjLuB6TptSxV97L/9/QSrE2U
4JteFGVwRBJw1s7k8ICf4s22debUZ+OlB0mXjI+8EUDt6vdMeregn5ilQQSsDmBMnz2GzHfV30tb
X92uoE5xui1g4Q3BWkUVwd9wVHaganr3rzc+lQDnQq5cddu1supu3SWp5FqKq36rtf3RX/3zHZ0C
P2pCAlilDHYH2NRF8CYb+gqFySS/PUxwPmFWuD897Hewokex+ux0oZscsuRe0IttCbYfjl/+tSA0
a6Rd+AmkiyASFgEHsLGl6q2OTPYU1PikjUe5RXTp0UC7bdPQXzxaORlh/KWilnz/kV2XblDdybuc
Qz3eVIGvTANnIqPpz94oImrgHX48hMGiH5gGNznLwDBoQl4ZSfvlSi01TcUsYlHJD3LRZWbsh4VG
PDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDCsjlIbQJoxUU3h/cTAN
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgU6TOVgt56igvuTJy4oKfT5Zm7EOVNCsl
j/YyCPn38sswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYxMTA0
MjIzMTM0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEAgrFearfztgWiUGGSdnQzK1gn4+UWEwrh19UAJ90zYz2hIYKTEVFECpY96JklXj4FChHE
ttr+WoLq5oFId29lKVsmJdyVoelD8mgYO9HYHbTDA9gAoh6pT039zElRJTIPYs3tOBs9cNqOK82v
isS8ODmAxt26a/8PPPev9mZ0aHmC/FzXMWrGXPeJ0KSjU2VjfgFDbqXV4liVuejZ+y/rDdEtATEJ
IyMrRFeexrV4OzZBVepYD7vwlhtmNLjDAeKTGQ0l5J/L9J7o0d9eBkxQOKhLYw49l2oN4+z9wfa3
p7cXDuPsHUWFU4kQO+zRQFCxDIWmk2XE5q4YSH+VGZEv6Q==
--0000000000000a7ac8065f7af14b--
