Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6B3112AB
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274058; cv=none; b=dXe0p3eAktt35TmSR0l9QNL5+wMuPd/HSF6/YtuQX6zmjv505qi/YMLTEiDha8ieH6vs5atKBqdVlY+3vnBg3eb3Kmus3eTX4ohzVZKRUky4rJna0YnHhal1JnfAG19CaqNB76lwmkPEfR/t8YHgj1aCavVo6ZNXqwXL29Bxtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274058; c=relaxed/simple;
	bh=H/kOaU/X8Q6SE5dTQG0tfADH5z5v2w33tRi2m7wiLxI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GT0TPD8LA3m4MNZgTnurOkueDF8BLI+cy3MVGFGwKr8C0K8kWUR49jnbu2+ambP1OK694/H63D8Q8ntLfcbu3yX27vQzBqOxNVBy2bMDQDCeBZMDUH7HLtq8PaEFnySeIaLDH1a18TOXx6ur7TFZD4BNEnnjZJ6xrIKDIkZutuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0QEFh+h; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0QEFh+h"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157d3f2098so45258185a.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274055; x=1782878855; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0U0HH35Ja+y+QNiJP5j6Io9a4TymbU2PoMxHvJIoxY=;
        b=M0QEFh+hc4QPjdDvIGL/6GIB4eW5NTFZNuqb9gDFVvxpndBeUZHA0u+0cPcyVvx8Sj
         i1H7D93Qoze6qNsuHwAeAfvdErI4advFPRNuSUbOz4X7yG85Hl6W049leG7imKoFxOiJ
         t9w82zWwOGZO3Ps+MJ5MEpbQzyhWfLMQYAZ3m20jdepCEYeo1bwbRDPZdFeZVTufovKB
         qs2gVreFruV8fig8Esd+VDGE96SUmr0uJndDQe1V2UIFp8J2OqS8z4BbAv8Fr+O9Yh7n
         oozpxAnnm3LS1FKLHg7FGxu9lkKXfihssWulgNdF174tdVksGK9M+Nc/Js25L5eHmG5m
         zhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274055; x=1782878855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0U0HH35Ja+y+QNiJP5j6Io9a4TymbU2PoMxHvJIoxY=;
        b=kG71TtIOV+7otE18USAwiK+40vJHTJtjHluhyhYu3QFj4yfevB6PfL0z+5odPUeiLi
         bBc/hsXGE+4Olu9u5K1qCzHuq34ZhX9Wb4g2QAcvN63iAqPKCutkq7KmWlMpSw29fmWR
         bQYiaW3IkWdZoKgN74hvpmM/ZO8+fgz6gbiEY82YCVS9v6RCX+Xwo71pvjDZEeLKXS6j
         b76KvmC0Xm9i9PHcF/9DXXlNbUqSK64O5IO0v2enw0N4uZGRYaVCNxTLSvl09nCHs6KT
         ei7nGo14liYOVVkcJBTdQbZ9H8zvHfBH+MENDVqxcGplv7VoED5qK/82HnMz9aEiPUL7
         GfbA==
X-Forwarded-Encrypted: i=1; AFNElJ8W4VvfAN1kKG1YXa5kVb0tc1Bm6JVoqgngg7rATdLMeNcjoWN8AeFfBF+6dNdNtM5a9WUovLZI5Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpxIWrOcpUeCjZfhqB8BUSoFhsJTw4XfiQaVHROFU4CQzGhv+
	u/pGIBPYnDBYl49T/c/7ZjkhYjcpGGPqZU6zpAtPQJRjsVouHANNcoDb
X-Gm-Gg: AfdE7cmWGgrrfa1BJ2R7gjZr3IjIjkkogpPGUvFGppxSI6XMYhGF5STgHTHP58y51tu
	PjkVT/p97HwXXjgR5TSEBrS+fEC3zaurnI6FNaKMsOt5e7B0bX1Yh0zfK1KZ85yPyoDkPdCN5Ot
	1BrzaRdH2D1qq0R7jktwr+696vwbIcwlxh3jSS+4lFeu0HPXdCOx5+K53uXai+uKFnl2o4CWE4s
	QqNzQL4gonwDgSoLKRfkSNfvI5KGGzCCJRZDhdZ+Sg86z5WkuMU6ZvmQBgna0cUR6pMw2fn/94V
	F7N0b48fRAqnWl9f+8Y+X0n9nBJJ24De63q0lT5vujW+i2s1f9fSgWZva+Nb9+DebVIhRAdNtst
	Jnge4QF8bJyccWQFPJDsYWpnK43qXSdTzjY0ZIJYQ172qjNXw3IFYBBJpDb1UNQK5r/LcXQ8voq
	MTBPkHUiZ76Q8bw9fN6BTIcV3NG+q09BkiOFFyH3gK8P4XoiK+j8drGg==
X-Received: by 2002:a05:620a:2a05:b0:915:c615:388 with SMTP id af79cd13be357-92648dc3771mr1040127385a.55.1782274054802;
        Tue, 23 Jun 2026 21:07:34 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:1d9f:8123:1ead:e34b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda62efesm442229585a.19.2026.06.23.21.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2026 21:07:34 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <ajmdy4yoYh7S2kS6@SMW015318>
Date: Wed, 24 Jun 2026 00:07:02 -0400
Cc: mani@kernel.org,
 kwilczynski@kernel.org,
 kishon@kernel.org,
 Frank.Li@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 bhelgaas@google.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37E4513B-53DA-4C91-9A8B-D1AF8910FB2D@gmail.com>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
 <ajmdy4yoYh7S2kS6@SMW015318>
To: Frank Li <Frank.li@oss.nxp.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jun 22, 2026, at 16:40, Frank Li <Frank.li@oss.nxp.com> wrote:
>=20
> On Mon, Jun 22, 2026 at 12:52:49PM -0400, Shuangpeng Bai wrote:
>> [You don't often get email from shuangpeng.kernel@gmail.com. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>=20
>> An open miscdevice file descriptor can outlive the PCI driver =
binding.
>> misc_deregister() removes the device node and prevents new opens, but =
it
>> does not revoke file descriptors that are already open.
>>=20
>> Before this change, pci_endpoint_test stored the miscdevice inside =
struct
>> pci_endpoint_test, and ioctl() recovered the test object from
>> file->private_data with container_of(). Since the test object was =
allocated
>> with devm_kzalloc(), it was freed when the PCI device was unbound. A
>> process could therefore open /dev/pci-endpoint-test.N, unbind the PCI
>> device through sysfs, and then issue an ioctl on the stale file =
descriptor,
>> causing a use-after-free of struct pci_endpoint_test.
>=20
> Anyways to provent unbound when still open? This driver is only for =
test
> ednpoint funciton, it is not worth to make complex for this unusual =
case.
>=20

Thanks, Frank.

Agreed. I looked at preventing unbind while the miscdevice is still =
open,
but I do not see a simple way to do that from this PCI driver. The other
approaches make the fix more complicated than the issue warrants for =
this
test endpoint driver.

I'll drop this patch for now. If there is a simpler preferred approach,
I would be happy to look at it.

Thanks,
Shuangpeng

> Frank
>=20
>>=20
>> Manage the test object lifetime explicitly. Allocate it with =
kzalloc_obj(),
>> add a kref, take a reference from .open(), and drop it from =
.release().
>> The remove path deregisters the miscdevice to stop new opens, =
serializes
>> with ioctl using the existing mutex, releases the PCI resources, =
clears
>> test->pdev, and drops the probe reference.
>>=20
>> Use the same 1s timeout already used by the other endpoint interrupt =
tests
>> for the READ, WRITE and COPY completion waits. This prevents device =
unbind
>> from blocking indefinitely behind an ioctl waiting for a missing =
endpoint
>> interrupt. Already-open file descriptors then keep the test object =
alive;
>> subsequent ioctls fail with -ENODEV instead of touching released =
device
>> resources.
>>=20
>> Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test =
function device")
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> Closes: =
https://lore.kernel.org/all/178144969601.60470.7358419009914000395@gmail.c=
om/
>> Suggested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
>> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> ---
>> Changes in v2:
>> - Bound READ, WRITE and COPY completion waits with the same 1s =
timeout used
>>  by the other endpoint interrupt tests so device unbind cannot block
>>  indefinitely behind an ioctl waiting for a missing endpoint =
interrupt.
>>=20
>> Please let me know if there are any concerns with this approach or if =
there
>> is a simpler preferred way to handle this lifetime.
>>=20
>> ---
>> drivers/misc/pci_endpoint_test.c | 86 =
++++++++++++++++++++++++++++----
>> 1 file changed, 77 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/misc/pci_endpoint_test.c =
b/drivers/misc/pci_endpoint_test.c
>> index dbd017cabbb9..65d768dab450 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -13,6 +13,7 @@
>> #include <linux/io.h>
>> #include <linux/interrupt.h>
>> #include <linux/irq.h>
>> +#include <linux/kref.h>
>> #include <linux/miscdevice.h>
>> #include <linux/module.h>
>> #include <linux/mutex.h>
>> @@ -136,6 +137,7 @@ enum pci_barno {
>> };
>>=20
>> struct pci_endpoint_test {
>> +       struct kref     kref;
>>        struct pci_dev  *pdev;
>>        void __iomem    *base;
>>        void __iomem    *bar[PCI_STD_NUM_BARS];
>> @@ -143,7 +145,7 @@ struct pci_endpoint_test {
>>        int             last_irq;
>>        int             num_irqs;
>>        int             irq_type;
>> -       /* mutex to protect the ioctls */
>> +       /* mutex to serialize ioctls and removal */
>>        struct mutex    mutex;
>>        struct miscdevice miscdev;
>>        enum pci_barno test_reg_bar;
>> @@ -157,6 +159,15 @@ struct pci_endpoint_test_data {
>>        size_t alignment;
>> };
>>=20
>> +static void pci_endpoint_test_free(struct kref *kref)
>> +{
>> +       struct pci_endpoint_test *test =3D container_of(kref,
>> +                                                    struct =
pci_endpoint_test,
>> +                                                    kref);
>> +
>> +       kfree(test);
>> +}
>> +
>> static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test =
*test,
>>                                          u32 offset)
>> {
>> @@ -804,10 +815,17 @@ static int pci_endpoint_test_copy(struct =
pci_endpoint_test *test,
>>        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>>                                 COMMAND_COPY);
>>=20
>> -       wait_for_completion(&test->irq_raised);
>> +       if (!wait_for_completion_timeout(&test->irq_raised,
>> +                                        msecs_to_jiffies(1000))) {
>> +               ret =3D -ETIMEDOUT;
>> +               goto err_dst_unmap;
>> +       }
>>=20
>> +err_dst_unmap:
>>        dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
>>                         DMA_FROM_DEVICE);
>> +       if (ret)
>> +               goto err_dst_phys_addr;
>>=20
>>        dst_crc32 =3D crc32_le(~0, dst_addr, size);
>>        if (dst_crc32 !=3D src_crc32)
>> @@ -909,12 +927,17 @@ static int pci_endpoint_test_write(struct =
pci_endpoint_test *test,
>>        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>>                                 COMMAND_READ);
>>=20
>> -       wait_for_completion(&test->irq_raised);
>> +       if (!wait_for_completion_timeout(&test->irq_raised,
>> +                                        msecs_to_jiffies(1000))) {
>> +               ret =3D -ETIMEDOUT;
>> +               goto err_unmap_addr;
>> +       }
>>=20
>>        reg =3D pci_endpoint_test_readl(test, =
PCI_ENDPOINT_TEST_STATUS);
>>        if (!(reg & STATUS_READ_SUCCESS))
>>                ret =3D -EIO;
>>=20
>> +err_unmap_addr:
>>        dma_unmap_single(dev, orig_phys_addr, size + alignment,
>>                         DMA_TO_DEVICE);
>>=20
>> @@ -1000,10 +1023,17 @@ static int pci_endpoint_test_read(struct =
pci_endpoint_test *test,
>>        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>>                                 COMMAND_WRITE);
>>=20
>> -       wait_for_completion(&test->irq_raised);
>> +       if (!wait_for_completion_timeout(&test->irq_raised,
>> +                                        msecs_to_jiffies(1000))) {
>> +               ret =3D -ETIMEDOUT;
>> +               goto err_unmap_addr;
>> +       }
>>=20
>> +err_unmap_addr:
>>        dma_unmap_single(dev, orig_phys_addr, size + alignment,
>>                         DMA_FROM_DEVICE);
>> +       if (ret)
>> +               goto err_phys_addr;
>>=20
>>        crc32 =3D crc32_le(~0, addr, size);
>>        if (crc32 !=3D pci_endpoint_test_readl(test, =
PCI_ENDPOINT_TEST_CHECKSUM))
>> @@ -1141,10 +1171,15 @@ static long pci_endpoint_test_ioctl(struct =
file *file, unsigned int cmd,
>> {
>>        int ret =3D -EINVAL;
>>        enum pci_barno bar;
>> -       struct pci_endpoint_test *test =3D =
to_endpoint_test(file->private_data);
>> -       struct pci_dev *pdev =3D test->pdev;
>> +       struct pci_endpoint_test *test =3D file->private_data;
>> +       struct pci_dev *pdev;
>>=20
>>        mutex_lock(&test->mutex);
>> +       pdev =3D test->pdev;
>> +       if (!pdev) {
>> +               ret =3D -ENODEV;
>> +               goto ret;
>> +       }
>>=20
>>        reinit_completion(&test->irq_raised);
>>        test->last_irq =3D -ENODATA;
>> @@ -1206,9 +1241,30 @@ static long pci_endpoint_test_ioctl(struct =
file *file, unsigned int cmd,
>>        return ret;
>> }
>>=20
>> +static int pci_endpoint_test_open(struct inode *inode, struct file =
*file)
>> +{
>> +       struct miscdevice *miscdev =3D file->private_data;
>> +       struct pci_endpoint_test *test =3D to_endpoint_test(miscdev);
>> +
>> +       kref_get(&test->kref);
>> +       file->private_data =3D test;
>> +
>> +       return 0;
>> +}
>> +
>> +static int pci_endpoint_test_release(struct inode *inode, struct =
file *file)
>> +{
>> +       struct pci_endpoint_test *test =3D file->private_data;
>> +
>> +       kref_put(&test->kref, pci_endpoint_test_free);
>> +       return 0;
>> +}
>> +
>> static const struct file_operations pci_endpoint_test_fops =3D {
>>        .owner =3D THIS_MODULE,
>> +       .open =3D pci_endpoint_test_open,
>>        .unlocked_ioctl =3D pci_endpoint_test_ioctl,
>> +       .release =3D pci_endpoint_test_release,
>> };
>>=20
>> static void pci_endpoint_test_get_capabilities(struct =
pci_endpoint_test *test)
>> @@ -1241,10 +1297,11 @@ static int pci_endpoint_test_probe(struct =
pci_dev *pdev,
>>        if (pci_is_bridge(pdev))
>>                return -ENODEV;
>>=20
>> -       test =3D devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
>> +       test =3D kzalloc_obj(*test);
>>        if (!test)
>>                return -ENOMEM;
>>=20
>> +       kref_init(&test->kref);
>>        test->pdev =3D pdev;
>>        test->irq_type =3D PCITEST_IRQ_TYPE_UNDEFINED;
>>=20
>> @@ -1263,7 +1320,7 @@ static int pci_endpoint_test_probe(struct =
pci_dev *pdev,
>>        ret =3D pci_enable_device(pdev);
>>        if (ret) {
>>                dev_err(dev, "Cannot enable PCI device\n");
>> -               return ret;
>> +               goto err_kfree_test;
>>        }
>>=20
>>        ret =3D pci_request_regions(pdev, DRV_MODULE_NAME);
>> @@ -1349,6 +1406,9 @@ static int pci_endpoint_test_probe(struct =
pci_dev *pdev,
>> err_disable_pdev:
>>        pci_disable_device(pdev);
>>=20
>> +err_kfree_test:
>> +       kfree(test);
>> +
>>        return ret;
>> }
>>=20
>> @@ -1364,10 +1424,13 @@ static void pci_endpoint_test_remove(struct =
pci_dev *pdev)
>>        if (id < 0)
>>                return;
>>=20
>> +       misc_deregister(&test->miscdev);
>> +
>> +       mutex_lock(&test->mutex);
>> +
>>        pci_endpoint_test_release_irq(test);
>>        pci_endpoint_test_free_irq_vectors(test);
>>=20
>> -       misc_deregister(&test->miscdev);
>>        kfree(misc_device->name);
>>        kfree(test->name);
>>        ida_free(&pci_endpoint_test_ida, id);
>> @@ -1378,6 +1441,11 @@ static void pci_endpoint_test_remove(struct =
pci_dev *pdev)
>>=20
>>        pci_release_regions(pdev);
>>        pci_disable_device(pdev);
>> +       pci_set_drvdata(pdev, NULL);
>> +       test->pdev =3D NULL;
>> +       mutex_unlock(&test->mutex);
>> +
>> +       kref_put(&test->kref, pci_endpoint_test_free);
>> }
>>=20
>> static const struct pci_endpoint_test_data default_data =3D {
>> --
>> 2.34.1
>>=20

