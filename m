Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53010 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab3DYDQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 23:16:53 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so3070007iej.16
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 20:16:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5E18B0C6DCFE1D46967DE5C51CD1AF9866346957@nkgeml506-mbx.china.huawei.com>
References: <CAAh6nkmbKR3HTqm5ommevsBwhL_u0N8Rk7Wsms_LfP=nBgKNew@mail.gmail.com>
	<CAAh6nkmkbKh7FjEZea4GmEbZvH4qvnfOJ2Og8xHYm5othsWLwQ@mail.gmail.com>
	<CAErSpo6zf34MOLNh5t_PifYhA87vFLRRx-g0WG5N=8+oUcWukQ@mail.gmail.com>
	<3400627.YcEmgrxv5I@vostro.rjw.lan>
	<CAE9FiQX7zyaZVm7QsZnOXtRD9qcCGCFpi2DLve863juL1ZxcWQ@mail.gmail.com>
	<5E18B0C6DCFE1D46967DE5C51CD1AF9866346957@nkgeml506-mbx.china.huawei.com>
Date: Wed, 24 Apr 2013 20:16:53 -0700
Message-ID: <CAE9FiQWFiOebCdGrzooMdhBfAHs7FUXX6piNi0p6J422Zs9ODw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_About_dynamically_loading_the_acpiphp=2Eko?=
From: Yinghai Lu <yinghai@kernel.org>
To: "Liujiang (Gerry, Euler)" <jiang.liu@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Guo <tuffkidtt@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 24, 2013 at 7:08 PM, Liujiang (Gerry, Euler)
<jiang.liu@huawei.com> wrote:
> Hi Yinghai,
>         I have worked out a similar patch last night. Please refer to attachment.
> I think following code may not work because acpiphp_handle_to_bridge()
> will return NULL.

for root bus we have
pcibios_add_bus. ==> acpi_pci_add_bus==>call acpiphp_enumerate_slots.
so if there is hotplug slot on root bus directly, it will allocate the
acpiphp_bridge and register the slots.

then acpiphp_handle_to_bridge will return the right acpiphp_bridge with
slots list.


> Could you please help to review my version?
>         (Due to work environment limitations, sorry for sending out without
> attachment and outlook).

looks the same to my patch, except you missed the acpiphp_check_bridge
calling.

Thanks

Yinghai
