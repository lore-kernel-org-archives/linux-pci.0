Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366E3002CF
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273301; cv=pass; b=GWElc4DP1UT/z27qRNkmUQNDVDMB5LnJbSRL4N8b5J3hu8sizJILQzneZUjOyNNStuwC+3iDkV9kIaKcqZ9/8/HI7tzkyph8TedWdN7eCoFWAMjSoiuNGXQqWng17UgZF3r/IUfel5DLqzYEKDb0tyuqMncrcaO3K+qM0e90x+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273301; c=relaxed/simple;
	bh=khqxR8OqLPM9lh9bkqo3PqJKBUxT1pC4fl8icSu6o2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX58zbsZapwb0kgr28n3l2lH8AmRLCVUR54pVQDOPy26G7X5f9kbZ/XA0g7I317RQzo0IPKQSzA5ohlrcBaomR0KLnGy6k50RCuNh9lsqHjk9OFIX64kLCyi+IbSDKibMJ8q/Oj8nOClZBVrm0dnAPQejSAqRiZ9L1RtVeATKoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPU/OWNp; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPU/OWNp"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-660390a8999so1130673d50.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781273299; cv=none;
        d=google.com; s=arc-20240605;
        b=KvIFguGwF8xgsT5mAz9XTsVJKDdjgNg+GFdro7qNwPyzfC7bGOQFOw/WibklE/+sQR
         08C5V4I3sUQSSCqVBmRxeY+o/0AE/hanW6IDU588AztOuHwPi+cOqQnam1DN5btR2wd2
         8VD5jG4fgE+GuWU69N/erS6qGRXW1/T8b3d0ysZAi1/XK7oPCSYFxT8F2pbXwaz2Vbdv
         Xc4s+v39mqJftbWWmv5c59zIL1Cm6wjuSSb/KhzphlU/i86hjJQtz3yXLqPIFtEad+RM
         A0rIab/xFPZUsWXvuxxUETyf8G5juQsVoyzzOVTF6YwRe+zVF1Lg4lxfDBXjAAKaRx+S
         B6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlgG0xvq8o8EXhAlmvhvq+Wb8r/3qL/fd7u4UykruzQ=;
        fh=BlYeJFKgzGcK2B09Pp762FJD+e+5oEoZl+tL6vbaa4I=;
        b=JsNJXS7LMUTPSDZH/3P+YzOJczM0HAxmzKOqX9Kubmy/crRmoXPNCsA6LXRyupWGKt
         RKg1V1U2OTj0Z7+2zSBbwMj7ZuQcjyd0CfzAxpph8uUC5XB38yjAVXZUT8lL/lmOlEkv
         7/D1vk+74lKyTiDggvNzEcxBeT/Wq78PevV8LJSDAQ6rUTCpQ9CHTDi+Xp9UdTjZ1lSh
         9EVhSKYBJrYL2lvhMXtW2925zuFhhOuzfndBenY9YsArYCQoRwh6LzgrFq3qeBvIh9MM
         sVhF7YNObDmpp6WhvKF4Z/eBLZdqYNi9WdboBKRC0d0rFL3XWaeI5dVzAQ2N/mOkLexB
         Dv3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781273299; x=1781878099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlgG0xvq8o8EXhAlmvhvq+Wb8r/3qL/fd7u4UykruzQ=;
        b=aPU/OWNp4DWAVTRB2YM7oU5uFiDmV/WcO/OLHoJ6ps/r5Tpr6Nbv4qOvxyJGFBeszC
         ttsLKCUCmAsB+DwMWxyxA4AgXTBBFpyACqUYrcN/miLvDlex1kP0fT+/RaGEMBoDYsne
         6U5mJ64v3+xsyCPrqa766Y9+OX8Bv9LfVm0QSqIZLbRTUM6wxLot4Xfu3AGMafVxJlF1
         hZ7azSu/hYlXTnHmvS8rVYznOecCw+P9+IYX/OuIhFQXysOuwTi9WBwG+5dsCvWpHMxI
         kdjual8dG9zgQrFhfqnx+P12XzG7yNGacRZXYTnag0NzmBK1Xvfh6lS5qMFBkaX5PXXj
         8/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273299; x=1781878099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlgG0xvq8o8EXhAlmvhvq+Wb8r/3qL/fd7u4UykruzQ=;
        b=n7/7oFS4LX0aqlg5E7+E5WJUX600JpcHKV1fNatzwW1ZLnzifVSKQdoa8Uqtr0Dh3r
         ZKAW31XEIbdy9XpfFd+HRuF69A4mE/F5NPykw3Q6dGtPpkXCw2P12brL4eWhEXYsGahl
         m9Zpq2NJqAOxKTV6T5sH1cf7EJdRr/fliXA+26Mlgz8rFxfSWv6LElmswMDlcjBnBJfJ
         jf6mEr+oHR42BYa1JCemat9wJ0hP5DsuUy2qMpUoNUBx963abjLckg+KV4Nd2kykmrLy
         0nq4UyLxaErUUkjjz9VSXYsILc9al0gmaGJfzYeji0NxxDBMocLk1qO/Dy4lSvjY3Wo1
         aUCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dI3MnbPYLXbQX54GWszJEAq/GDqveRu8Pgt6uBEwyo1zyLi1EBIrPIwbzTSN57klAPFroDhUIAK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUHatkdHSpHjCl2yl/VTyoAyKox8NCAK+kpwl2NqV6WXrlGr/0
	IL3SG6/C2IiyvVlFUuBpXuTEIZ/2jhNqRci4gjlWQN96cGJLaGWPmJymuyIQX6Gkc9inGgyCODT
	xq5iOiTlwuiAsAoZhfwYFS56f94PDCyY=
X-Gm-Gg: Acq92OEtthWHcsLbE2/9VXRbG86YSz/eqIm20pHgzCe7SqwzMA99fbZNW/rkVX7w+KT
	BJnhIAVnGF46Lizejk8MglWqhIZ6fA8oHPyqtrLYX0SM4hsARJzlO6tT99Zq99itI0w8pGHK/nF
	FrxVhzLly1/E/Qs8Ya9+tCXG+Z4byeQfeLnfoIR+7F0/knn3Fc9JNJrLcZRES/vZPy6ru1QYJo2
	Yduk2v46ne1Bo75R/Q7LMbrYHowz5I7gk/Cx8ed67lEsfRedvReJ6Jovg/VRsA5PJsNyDlGeTQe
	QlQxwniix8BDUq2UCrdhCtB8EBGWrc9JfX792DRqzYzpD1xlpZ+epI7XapmV7FSyUvvuAA==
X-Received: by 2002:a05:690e:4105:b0:651:c160:1c06 with SMTP id
 956f58d0204a3-66278522da4mr2339113d50.58.1781273298803; Fri, 12 Jun 2026
 07:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 11:08:06 -0300
X-Gm-Features: AVVi8Cc6Z1U4kn8TsqiEGnkR9_5-CwxCuOwHI-X60qY3Ecczz1S6QYEe6MkyQvM
Message-ID: <CABBYNZJY68zrRO49VEtgEVzQfqVY9QZzwUuc8VoKkAAeKUwAOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Thu, Jun 11, 2026 at 10:29=E2=80=AFPM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> Add a u8 reset_type parameter to the hdev->reset() callback to allow
> userspace to select the reset method via sysfs. Writing 1 to
> /sys/class/bluetooth/hci0/reset triggers a Product Level Device
> Reset (PLDR), while any other value triggers a Function Level Reset
> (FLR).
>
> The reset_type values are:
>   0 - Function Level Reset (FLR)
>   1 - Product Level Device Reset (PLDR)

This should probably be treated as a generic level at the sysfs level,
then each vendor can interpret according to its own needs, for
btintel_pcie that would result in the above levels.

> Internal callers (command timeout, suspend/resume, coredump)
> default to FLR (0).
>
> All drivers implementing the reset callback are updated to accept
> the new parameter:
>   - btusb: btusb_intel_reset, btusb_qca_reset, btusb_rtl_reset
>   - hci_qca: qca_reset
>   - btmtksdio: btmtksdio_reset
>   - btmtk: btmtk_reset_sync
>   - btnxpuart: nxp_reset
>   - btintel_pcie: btintel_pcie_reset (maps to Intel PRR types)
>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
>  Documentation/ABI/stable/sysfs-class-bluetooth |  6 +++++-
>  drivers/bluetooth/btintel_pcie.c               | 17 +++++++++++------
>  drivers/bluetooth/btmtk.c                      |  6 +++---
>  drivers/bluetooth/btmtk.h                      |  4 ++--
>  drivers/bluetooth/btmtksdio.c                  |  2 +-
>  drivers/bluetooth/btnxpuart.c                  |  2 +-
>  drivers/bluetooth/btusb.c                      |  6 +++---
>  drivers/bluetooth/hci_qca.c                    |  2 +-
>  include/net/bluetooth/hci_core.h               |  2 +-
>  net/bluetooth/hci_core.c                       |  2 +-
>  net/bluetooth/hci_sysfs.c                      | 10 ++++++++--
>  11 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..8f485fa02a47 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -3,7 +3,11 @@ Date:          14-Jan-2025
>  KernelVersion: 6.13
>  Contact:       linux-bluetooth@vger.kernel.org
>  Description:   This write-only attribute allows users to trigger the ven=
dor reset
> -               method on the Bluetooth device when arbitrary data is wri=
tten.
> +               method on the Bluetooth device. The value written selects=
 the
> +               reset type:
> +                 0 - Function Level Reset (FLR)
> +                 1 - Product Level Device Reset (PLDR)
> +               Writing any value other than 1 defaults to FLR.
>                 The reset may or may not be done through the device trans=
port
>                 (e.g., UART/USB), and can also be done through an out-of-=
band
>                 approach such as GPIO.
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 9e39327dc1fe..d3a03cf96421 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2486,7 +2486,7 @@ static void btintel_pcie_inc_recovery_count(struct =
pci_dev *pdev,
>  }
>
>  static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
> -static void btintel_pcie_reset(struct hci_dev *hdev);
> +static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type);
>
>  static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
)
>  {
> @@ -2680,7 +2680,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>         pci_unlock_rescan_remove();
>  }
>
> -static void btintel_pcie_reset(struct hci_dev *hdev)
> +static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btintel_pcie_data *data;
>
> @@ -2692,6 +2692,12 @@ static void btintel_pcie_reset(struct hci_dev *hde=
v)
>         if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->fl=
ags))
>                 return;
>
> +       data->reset_type =3D (reset_type =3D=3D 1) ?
> +                           BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOS=
F_PRR_FLR;
> +
> +       bt_dev_info(hdev, "Reset triggered: %s",
> +                   data->reset_type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR ? =
"PLDR" : "FLR");
> +
>         pci_dev_get(data->pdev);
>         schedule_work(&data->reset_work);
>  }
> @@ -2729,7 +2735,7 @@ static void btintel_pcie_hw_error(struct hci_dev *h=
dev, u8 code)
>                 return;
>         }
>         btintel_pcie_inc_recovery_count(pdev, &hdev->dev);
> -       btintel_pcie_reset(hdev);
> +       btintel_pcie_reset(hdev, (code =3D=3D 0x13) ? 1 : 0);
>  }
>
>  static bool btintel_pcie_wakeup(struct hci_dev *hdev)
> @@ -3111,8 +3117,7 @@ static int btintel_pcie_resume(struct device *dev)
>         if (data->pm_sx_event =3D=3D PM_EVENT_FREEZE ||
>             data->pm_sx_event =3D=3D PM_EVENT_HIBERNATE) {
>                 set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
> -               data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_FLR;
> -               btintel_pcie_reset(data->hdev);
> +               btintel_pcie_reset(data->hdev, 0);
>                 return 0;
>         }
>
> @@ -3143,7 +3148,7 @@ static int btintel_pcie_resume(struct device *dev)
>                         queue_work(data->coredump_workqueue, &data->cored=
ump_work);
>                 }
>                 set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
> -               btintel_pcie_reset(data->hdev);
> +               btintel_pcie_reset(data->hdev, 0);
>         }
>         return err;
>  }
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..641f62912f63 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -104,7 +104,7 @@ static void btmtk_coredump_notify(struct hci_dev *hde=
v, int state)
>         case HCI_DEVCOREDUMP_ABORT:
>         case HCI_DEVCOREDUMP_DONE:
>                 data->cd_info.state =3D HCI_DEVCOREDUMP_IDLE;
> -               btmtk_reset_sync(hdev);
> +               btmtk_reset_sync(hdev, 0);
>                 break;
>         }
>  }
> @@ -384,7 +384,7 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bdad=
dr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
>
> -void btmtk_reset_sync(struct hci_dev *hdev)
> +void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btmtk_data *reset_work =3D hci_get_priv(hdev);
>         int err;
> @@ -1403,7 +1403,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                 if (err < 0) {
>                         /* retry once if setup firmware error */
>                         if (!test_and_set_bit(BTMTK_FIRMWARE_DL_RETRY, &b=
tmtk_data->flags))
> -                               btmtk_reset_sync(hdev);
> +                               btmtk_reset_sync(hdev, 0);
>                         bt_dev_err(hdev, "Failed to set up firmware (%d)"=
, err);
>                         return err;
>                 }
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..5cda42444e94 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -196,7 +196,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, c=
onst char *fwname,
>  int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
>                          wmt_cmd_sync_func_t wmt_cmd_sync);
>
> -void btmtk_reset_sync(struct hci_dev *hdev);
> +void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type);
>
>  int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
>                             u32 fw_version);
> @@ -244,7 +244,7 @@ static inline int btmtk_setup_firmware(struct hci_dev=
 *hdev, const char *fwname,
>         return -EOPNOTSUPP;
>  }
>
> -static inline void btmtk_reset_sync(struct hci_dev *hdev)
> +static inline void btmtk_reset_sync(struct hci_dev *hdev, u8 reset_type)
>  {
>  }
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index c6f80c419e90..3c4401ce1e00 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1269,7 +1269,7 @@ static int btmtksdio_send_frame(struct hci_dev *hde=
v, struct sk_buff *skb)
>         return 0;
>  }
>
> -static void btmtksdio_reset(struct hci_dev *hdev)
> +static void btmtksdio_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btmtksdio_dev *bdev =3D hci_get_drvdata(hdev);
>         u32 status;
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e7036a48ce48..e2416b48116c 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1539,7 +1539,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
>         return false;
>  }
>
> -static void nxp_reset(struct hci_dev *hdev)
> +static void nxp_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 08c0a99a62c5..d701c7d82cad 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1043,7 +1043,7 @@ static void btusb_reset(struct hci_dev *hdev)
>         usb_queue_reset_device(data->intf);
>  }
>
> -static void btusb_intel_reset(struct hci_dev *hdev)
> +static void btusb_intel_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> @@ -1121,7 +1121,7 @@ static inline void btusb_rtl_alloc_devcoredump(stru=
ct hci_dev *hdev,
>         }
>  }
>
> -static void btusb_rtl_reset(struct hci_dev *hdev)
> +static void btusb_rtl_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> @@ -1165,7 +1165,7 @@ static void btusb_rtl_hw_error(struct hci_dev *hdev=
, u8 code)
>         btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
>  }
>
> -static void btusb_qca_reset(struct hci_dev *hdev)
> +static void btusb_qca_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 244447195619..02b4afe77669 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1693,7 +1693,7 @@ static void qca_hw_error(struct hci_dev *hdev, u8 c=
ode)
>         clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>
> -static void qca_reset(struct hci_dev *hdev)
> +static void qca_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>         struct hci_uart *hu =3D hci_get_drvdata(hdev);
>         struct qca_data *qca =3D hu->priv;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 7e15da47fe3a..00421352fcb5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -650,7 +650,7 @@ struct hci_dev {
>         int (*post_init)(struct hci_dev *hdev);
>         int (*set_diag)(struct hci_dev *hdev, bool enable);
>         int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> -       void (*reset)(struct hci_dev *hdev);
> +       void (*reset)(struct hci_dev *hdev, u8 reset_type);
>         bool (*wakeup)(struct hci_dev *hdev);
>         int (*set_quality_report)(struct hci_dev *hdev, bool enable);
>         int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5ba9fe8261ec..360b329ae6da 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1435,7 +1435,7 @@ static void hci_cmd_timeout(struct work_struct *wor=
k)
>         }
>
>         if (hdev->reset)
> -               hdev->reset(hdev);
> +               hdev->reset(hdev, 0);
>
>         atomic_set(&hdev->cmd_cnt, 1);
>         queue_work(hdev->workqueue, &hdev->cmd_work);
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 8957ce7c21b7..a4fe329158cf 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -97,8 +97,14 @@ static ssize_t reset_store(struct device *dev, struct =
device_attribute *attr,
>  {
>         struct hci_dev *hdev =3D to_hci_dev(dev);
>
> -       if (hdev->reset)
> -               hdev->reset(hdev);
> +       if (hdev->reset) {
> +               int val;
> +
> +               if (kstrtoint(buf, 10, &val) || val !=3D 1)
> +                       hdev->reset(hdev, 0);
> +               else
> +                       hdev->reset(hdev, 1);
> +       }
>
>         return count;
>  }
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
