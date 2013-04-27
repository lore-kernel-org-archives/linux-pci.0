Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <517B2F1B.6000704@huawei.com>
References: <1367024974-6063-1-git-send-email-yinghai@kernel.org>
	<517B2F1B.6000704@huawei.com>
Date: Fri, 26 Apr 2013 18:57:04 -0700
Message-ID: <CAE9FiQWLfdgR8VoqeVOpCdHa3TpK26Bgs7mZ7Ed+Zq60S=g8Vg@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI: Enable pci bridge when it is needed
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 26, 2013 at 6:51 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> I think it's cool! Now we enable bridge in various places, this is a headache.
>
> hi, yinghai, in this patch, enable bridges depend on the driver call pci_enable_device() explicitly.
> I was a little worried If there has some devices don't have some drivers bound, but used by system.
> like ioapic, these devices maybe implemented as pci device, but no pci drivers bind, also, maybe they
> won't call pci_enable_device() explicity. So if they are under the pci bridge, no one will enable the bridge
> for them.

If there is really that case, we could call pci_enable_device in
pci_final quirk for
them.

Yinghai
