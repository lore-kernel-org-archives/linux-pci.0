Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: hv: fix a couple of issues in hv_pci_onchannelcallback()
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
Date: Fri, 10 Jun 2016 14:05:33 +0200
In-Reply-To: <1464617879-19581-1-git-send-email-vkuznets@redhat.com> (Vitaly
	Kuznetsov's message of "Mon, 30 May 2016 16:17:57 +0200")
Message-ID: <87ziqt8d0y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> kmemleak helped me to identify a memory leak in hv_pci_onchannelcallback()
> and while fixing it I stumbled upon an unrelated issue(s) there.
>
> Vitaly Kuznetsov (2):
>   PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
>   PCI: hv: handle all pending messages in hv_pci_onchannelcallback()
>

Bjorn,

sorry for the ping but with both patches acked by Jake is there anything
else required for this series to get merged? It would be nice to have
these fixes in 4.7 but even knowing that they're queued for 4.8 is OK.

Thanks,

-- 
  Vitaly
