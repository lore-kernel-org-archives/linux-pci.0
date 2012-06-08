Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33945 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab2FHHBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jun 2012 03:01:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so2145497pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 08 Jun 2012 00:01:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338190380-5144-1-git-send-email-jiang.liu@huawei.com>
References: <1338190380-5144-1-git-send-email-jiang.liu@huawei.com>
Date: Fri, 8 Jun 2012 00:01:37 -0700
Message-ID: <CAE9FiQWTP1PP6hcfJ=ru5J=_dLH+q5oy4-OEg-Ws-2xWkxyGLg@mail.gmail.com>
Subject: Re: [PATCH] PCI: export symbol pci_bus_sem to module
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wu Fengguang <fengguang.wu@intel.com>
Cc: Amos Kong <kongjianjun@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: multipart/mixed; boundary=e89a8ff247a5454d9a04c1f09295
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--e89a8ff247a5454d9a04c1f09295
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2012 at 12:33 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Changeset "9080648 PCI: acpiphp: remove all functions in slot,
> even without ACPI _EJx" introduces pci_bus_sem into the acpiphp
> driver, but pci_bus_sem hasn't been exported to modules yet.
> So export symbol pci_bus_sem to modules, otherwise the acpiphp
> driver can't be built as module any more.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
> =A0drivers/pci/search.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 9d75dc8..e0c7a22 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -15,6 +15,8 @@
> =A0#include "pci.h"
>
> =A0DECLARE_RWSEM(pci_bus_sem);
> +EXPORT_SYMBOL(pci_bus_sem);
> +
> =A0/*
> =A0* find the upstream PCIe-to-PCI bridge of a PCI device
> =A0* if the device is PCIE, return NULL

Bjorn,

can you please fold this one into

9080648:
PCI: acpiphp: remove all functions in slot, even without ACPI _EJx

that commit now is in pci/for-3.6

Fengguang's auto compiling test robot reported same error on my
for-pci-root-bus-hotplug branch that is based on
pci/for-3.6.

Thanks

Yinghai

--e89a8ff247a5454d9a04c1f09295
Content-Type: application/octet-stream; name="fix_acpiphp_mod.patch"
Content-Disposition: attachment; filename="fix_acpiphp_mod.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h36wnfxz0

U3ViamVjdDogW1BBVENIXSBQQ0k6IEZpeCBjb21waWxpbmcgb2YgYWNwaXBocCBhcyBtb2R1bGUK
ClJlcG9ydGVkLWJ5OiBGZW5nZ3VhbmcgV3UgPHdmZ0BsaW51eC5pbnRlbC5jb20+ClNpZ25lZC1v
ZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9zZWFyY2guYyBiL2RyaXZlcnMvcGNpL3NlYXJjaC5jCmluZGV4IDlkNzVkYzguLjg2
MzBjYTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3NlYXJjaC5jCisrKyBiL2RyaXZlcnMvcGNp
L3NlYXJjaC5jCkBAIC0xNSw2ICsxNSw3IEBACiAjaW5jbHVkZSAicGNpLmgiCiAKIERFQ0xBUkVf
UldTRU0ocGNpX2J1c19zZW0pOworRVhQT1JUX1NZTUJPTF9HUEwocGNpX2J1c19zZW0pOwogLyoK
ICAqIGZpbmQgdGhlIHVwc3RyZWFtIFBDSWUtdG8tUENJIGJyaWRnZSBvZiBhIFBDSSBkZXZpY2UK
ICAqIGlmIHRoZSBkZXZpY2UgaXMgUENJRSwgcmV0dXJuIE5VTEwK
--e89a8ff247a5454d9a04c1f09295--
