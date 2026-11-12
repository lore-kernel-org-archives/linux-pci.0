Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479579;
	b=nd8BYtgYFhedaZ86r6JDcU6SMmlmjQhrRxfDsY7kYgbhPn7exNilaF9LWdN5BaLUJU9R
	 oEFQUhY6C2O6G8tZxIvoponZLhEc9ecY+Oaul4ZYUmyf4DuM6EGvfGCd29s6qR9i3eLX9
	 efqk/cFDH8LUbkYxbyoberJ6IA5S4gvIVGB0Tf3X3Sh1uNpwfVSHezd8kXEhyMQKMZXq9
	 CVWXeEZnFdTmWxqz4R33tmu8PhGawGgjnTZVDevENNg539fBXdcZb0A6QgaaJd2DedxQ6
	 S6r+t5jNXjjyteuObNDNgQxGs9iy/FZLTDV7QRECO4yjfuMNgAGwfpCAlTz8usyPKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479579;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7asrFaHTzZllDDUNciX3JSRX5gXUC5F4fBVc9Jkwf0E=;
	b=0UJdqs4GhwfSDAoko7yE4+1jniLZacCE97EDZPG6OXzvnlFDRHItjcKT7s7GcCJkPLvf
	 dFlCK+gmuB+gAIcq/rLIEK9uCW/xWPsftRWSnKg7oU/TnmL2nY+L3DYdCx7V5TMiZ+rDK
	 p+PvP4dp5MRZ5bVVr8rBy7yj2XMS7MuO0q0yazR8hI767tKNeLGrKLsOdTfjuata0xqm9
	 yI3XNLVhb2M4o4ydlMxRW25s8Bd8U0WSwk/O3RYl0k4pG/fDDFsAvHS77i7rmFaHC7DBU
	 rEDfZ+eQmMvWS1MxCyNZGB45XOUbs75/p/xdD9K/DARy0t1BTiJCN7lJbKtrn0SF9ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGb2yDtZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF86606A31C;
	Thu, 12 Nov 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGb2yDtZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E9D1F00A05;
	Thu, 12 Nov 2026 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479579;
	bh=7asrFaHTzZllDDUNciX3JSRX5gXUC5F4fBVc9Jkwf0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SGb2yDtZZqWFVT0guABW2rgY6yde91AMAt54K9zUMc6UNmu7S/V4fgWu69fKsfyPV
	 7Es8RO7tpcRecCeER9guaREA7sPOuG3WBLnorqOoYS6/o/S+jqXwzN2exs1B8sA3N/
	 ZF4JGs3m2/skadvs75aHgR/H6ByuPWU7sQ1BdFy1mJYih50uf3Zp+ccuiPVeVwtDCA
	 bR7Q5WXN7kDBxMaW3Jvayc6JUP0xbthJyaw/KGsHM7Svirv2yXY2jesLK5/Jg9PZyO
	 7OsRdD1RmzyyESGfks3oK20chkDsepDNhUJxWgPddg2c6NE2aQVDzmY1ONk0PsuEG1
	 X2DZOwBkjArtw==
Date: Thu, 12 Nov 2026 16:02:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <avWVnjF86FLFvfOC@debian>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com>
 <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
 <CAFEp6-3Mt-CCJEz=RAJUh6pxH-Ssgkqfx3QQfyzvS9HwzFp9QQ@mail.gmail.com>
 <906ebec9-de19-4a1e-9472-dcf8529fa232@packett.cool>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906ebec9-de19-4a1e-9472-dcf8529fa232@packett.cool>

On Mon, Oct 12, 2026 at 04:10:26PM -0300, Val Packett wrote:
> 
> On 10/9/26 1:40 PM, Loic Poulain wrote:
> > Hi Val,
> > 
> > On Thu, Oct 8, 2026 at 12:58 AM Val Packett <val@packett.cool> wrote:
> > > 
> > > On 10/5/26 9:21 AM, Loic Poulain wrote:
> > > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> > > > controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> > > > rather than a dedicated BT enable GPIO.
> > > > 
> > > > When the serdev controller has an OF graph (indicating it is connected to
> > > > an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> > > > power sequencer and use it to control BT power instead of the bt-enable
> > > > GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> > > > 
> > > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > > >    drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
> > > >    1 file changed, 37 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > index 1d27ff98034ba99d0783e48db5c605f3b31117ea..b6ec1a57248e2cf4bd138898ffc5cad45b1b4a8b 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
> > > >                        /* Controller needs time to bootup. */
> > > >                        msleep(150);
> > > >                }
> > > > +
> > > > +             if (qcadev->bt_power.pwrseq)
> > > > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> > > >        }
> > > > 
> > > >        clear_bit(QCA_BT_OFF, &qca->flags);
> > > > @@ -2396,6 +2399,34 @@ static int qca_init_regulators(struct qca_power *qca,
> > > >        return 0;
> > > >    }
> > > > 
> > > > +static void qca_serdev_put_pwrseq(void *data)
> > > > +{
> > > > +     pwrseq_put(data);
> > > > +}
> > > > +
> > > > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > > > +{
> > > > +     struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> > > > +     struct pwrseq_desc *pwrseq;
> > > > +
> > > > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > > > +             return 0;
> > > Seems like of_graph_is_present does *not* return false for the existing
> > > (non-connector) setup which is currently used in all the laptop device
> > > trees..
> > If I understand the issue correctly, this can only occur when a UART
> > 'port' is left unconnected, in which case the failure is legitimate.
> > The laptop device trees should be fixed accordingly, either by
> > connecting the port to the corresponding M.2 device or by using the
> > usual Bluetooth UART child-node approach. I don't see this issue in
> > mainline.
> 
> So it looks like this is because commit 014501d141ed ("arm64: dts: qcom:
> hamoa: Add graph port/endpoint anchors to pcie4_port0 and uart14")
> unconditionally added the uart14 endpoint to hamoa.dtsi itself in
> preparation for the future transition to proper M.2 descriptions.
> 
> The laptop dts'es themselves still have the older child-node description for
> bluetooth, with a dummy port { uart14_ep: endpoint {}; }; that's not used
> yet.
> 
> Could the check be extended to actually verify that there's actually
> something the graph endpoint is connected to? Or should that commit be
> reverted?
> 

Taken care now: https://lore.kernel.org/linux-arm-msm/20261112-hamoa-dt-fix-v1-1-55efbac840f4@oss.qualcomm.com/

I shouldn't have given my r-b tag for the offending patch :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
